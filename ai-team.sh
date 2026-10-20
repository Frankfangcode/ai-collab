#!/usr/bin/env bash
# 三家 AI 協作：Claude Code + Codex CLI (ChatGPT) + Gemini CLI
# 全部走「訂閱帳號登入」，不使用 API key。
# 用法：
#   ./ai-team.sh check                     檢查三個 CLI 是否安裝
#   ./ai-team.sh ask    "問題"              三家同時回答（並排比較）
#   ./ai-team.sh debate "問題"              圓桌：各自回答 → 互評修正 → Claude 統整
#   ./ai-team.sh review 檔案 ["要求"]        Codex + Gemini 審稿 → Claude 整合出修訂版
set -u
DIR="$(cd "$(dirname "$0")" && pwd)"
RUNS="$DIR/runs"
# 參與的 AI（可臨時覆寫：AI_AGENTS="claude codex" ./ai-team.sh ...）
# Gemini CLI 已於 2026/6/18 停用，gemini 這一家改走 Antigravity CLI（agy）
AGENTS="${AI_AGENTS:-claude codex gemini}"
REVIEWERS="$(echo $AGENTS | tr ' ' '\n' | grep -v '^claude$' | tr '\n' ' ')"

have() { command -v "$1" >/dev/null 2>&1; }
bin() { [ "$1" = gemini ] && echo agy || echo "$1"; }  # 名字 → 實際指令

# 呼叫單一 AI：$1=名字 $2=prompt $3=輸出檔（stderr 進 .log）
call() {
  local name="$1" prompt="$2" out="$3"
  if ! have "$(bin "$name")"; then echo "（$name 未安裝，略過）" > "$out"; return; fi
  case "$name" in
    claude) claude -p "$prompt" < /dev/null > "$out" 2> "$out.log" ;;
    codex)  codex exec --skip-git-repo-check "$prompt" < /dev/null > "$out" 2> "$out.log" ;;
    gemini) agy -p "$prompt" --print-timeout 10m < /dev/null > "$out" 2> "$out.log" ;;
  esac
  [ -s "$out.log" ] || rm -f "$out.log"
  [ -s "$out" ] || { echo "（$name 沒有回應，看 $(basename "$out").log）" > "$out"; }
}

newrun() {
  RUN="$RUNS/$(date +%Y%m%d-%H%M%S)-$1"
  mkdir -p "$RUN"
}

show() { echo; echo "════════ $1 ════════"; cat "$2"; }

others() { # 列出除了 $1 以外兩家的回答
  local me="$1" round="$2" a
  for a in $AGENTS; do
    [ "$a" = "$me" ] && continue
    printf '\n--- %s 的回答 ---\n' "$a"; cat "$RUN/$round-$a.md"
  done
}

cmd_check() {
  for a in $AGENTS; do
    if have "$(bin "$a")"; then echo "✅ $a  $(command -v "$(bin "$a")")"; else echo "❌ $a 未安裝（執行 ./setup.sh）"; fi
  done
}

cmd_ask() {
  local q="$1"; newrun ask
  echo "$q" > "$RUN/question.md"
  echo "⏳ 三家同時思考中…"
  for a in $AGENTS; do call "$a" "$q" "$RUN/$a.md" & done; wait
  for a in $AGENTS; do show "$a" "$RUN/$a.md"; done
  echo; echo "📁 存在 $RUN"
}

cmd_debate() {
  local q="$1"; newrun debate
  echo "$q" > "$RUN/question.md"
  echo "⏳ 第 1 輪：各自獨立回答…"
  for a in $AGENTS; do call "$a" "$q

請用繁體中文回答，條理清楚。" "$RUN/r1-$a.md" & done; wait

  echo "⏳ 第 2 輪：看別人的答案，互評並修正自己的…"
  for a in $AGENTS; do
    call "$a" "原始問題：
$q

你第一輪的回答：
$(cat "$RUN/r1-$a.md")

其他 AI 的回答：
$(others "$a" r1)

請：1) 指出別人答案中你認同與不認同之處（具體說明理由）；2) 給出你修正後的最佳答案。繁體中文。" "$RUN/r2-$a.md" &
  done; wait

  echo "⏳ 第 3 輪：Claude 擔任主持人統整…"
  call claude "你是圓桌主持人。原始問題：
$q

以下是各位 AI（codex = ChatGPT）互評後的修正答案：
$(for a in $AGENTS; do printf -- '--- %s ---\n' "$a"; cat "$RUN/r2-$a.md"; echo; done)

請輸出最終結論（繁體中文）：
## 共識
## 分歧點（誰主張什麼、你判斷哪個較有道理）
## 最終建議" "$RUN/final.md"
  show "最終結論" "$RUN/final.md"
  echo; echo "📁 每一輪的完整紀錄在 $RUN"
}

cmd_review() {
  local f="$1" req="${2:-請找出錯誤、邏輯漏洞與可改進之處}"
  [ -f "$f" ] || { echo "找不到檔案：$f"; exit 1; }
  newrun review; cp "$f" "$RUN/original-$(basename "$f")"
  local body; body="$(cat "$f")"
  echo "⏳ $REVIEWERS審稿中…"
  for a in $REVIEWERS; do
    call "$a" "你是嚴格的審稿人。要求：$req

以下是待審內容：
$body

請條列具體問題與修改建議（繁體中文），不要重寫全文。" "$RUN/review-$a.md" &
  done; wait
  echo "⏳ Claude 整合兩份審稿意見，產出修訂版…"
  call claude "以下是原文：
$body

$(for a in $REVIEWERS; do printf -- '--- %s 的審稿意見 ---\n' "$a"; cat "$RUN/review-$a.md"; echo; done)

請判斷哪些意見合理並採納，輸出：
1. 「採納／不採納」清單（一行一條，附理由）
2. 完整修訂版全文" "$RUN/revised.md"
  for a in $REVIEWERS; do show "$a 意見" "$RUN/review-$a.md"; done
  show "Claude 修訂版" "$RUN/revised.md"
  echo; echo "📁 存在 $RUN"
}

case "${1:-}" in
  check)  cmd_check ;;
  ask)    shift; cmd_ask "$*" ;;
  debate) shift; cmd_debate "$*" ;;
  review) shift; cmd_review "$1" "${2:-}" ;;
  *) sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//' ;;
esac
