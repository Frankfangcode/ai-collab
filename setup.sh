#!/usr/bin/env bash
# 一次安裝三個 CLI，並逐一用「訂閱帳號」登入（不要選 API key）
set -e
command -v node >/dev/null || { echo "請先安裝 Node.js：brew install node"; exit 1; }
npm install -g @anthropic-ai/claude-code @openai/codex
command -v agy >/dev/null || curl -fsSL https://antigravity.google/cli/install.sh | bash
echo
echo "接下來會依序開啟三個 CLI 讓你登入，登入完輸入 /exit（或 Ctrl+C）離開進下一個。"
read -p "1/3 Claude：選『Claude account with subscription』。按 Enter 開始…" _; claude || true
read -p "2/3 Codex：選『Sign in with ChatGPT』。按 Enter 開始…" _; codex login || codex || true
read -p "3/3 Gemini（Antigravity）：選『Google OAuth』。按 Enter 開始…" _; ~/.local/bin/agy || true
echo; "$(dirname "$0")/ai-team.sh" check
