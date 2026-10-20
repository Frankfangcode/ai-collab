# AI 協作：Claude × ChatGPT × Gemini（全用訂閱，不用 API）

## 第一次設定（在 Mac「終端機」做一次）
```bash
cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/AI\ 協作
./setup.sh
```
會安裝 Claude Code、Codex CLI、Antigravity CLI（`agy`），並逐一跳出登入。**都選訂閱帳號登入，不要選 API key。**

> Gemini CLI 已於 2026/6/18 停止服務，Gemini 這一家改用 Google 的 Antigravity CLI（`agy`），需 Google AI Pro/Ultra 訂閱。

## 用法一：一行指令讓三家協作
| 指令 | 做什麼 |
|---|---|
| `./ai-team.sh ask "問題"` | 三家同時回答，並排比較 |
| `./ai-team.sh debate "問題"` | 圓桌：各自回答 → 看彼此答案互評修正 → Claude 統整出共識／分歧／結論 |
| `./ai-team.sh review 檔案.md "要求"` | Codex + Gemini 分別審稿 → Claude 判斷採納哪些，輸出修訂版 |

每次的完整紀錄都存在 `runs/` 資料夾。

## 用法二：在 Claude Code 裡讓它自己找隊友
在這個資料夾執行 `claude`，`CLAUDE.md` 已經設定好它是總指揮，會在需要時自己呼叫 `codex` 和 `agy`（Gemini）。直接說：
> 「寫一個 Python 爬蟲，寫完請 Gemini 審查」
> 「這個決定問一下另外兩個 AI 的看法」

`AGENTS.md`、`GEMINI.md` 分別是 Codex 和 Gemini 在這個資料夾的角色設定。

## 注意
- 三家額度各自計算，`debate` 每次會用掉 Claude 3 次、另外兩家各 2 次
- 想暫時只用其中幾家：`AI_AGENTS="claude codex" ./ai-team.sh debate "問題"`
- `gaiacraft 企劃/` 是用這套流程做的實際案例：三家分工調查、提出網站改版企劃
