# 三家共同設計：從討論到一份 HTML

成品：**[gaiacraft-共同版.html](gaiacraft-共同版.html)**（第一版備份：`gaiacraft-共同版-v1.html`）

## 流程
| 輪 | 做什麼 | 檔案 |
|---|---|---|
| 0 | 共用素材：截圖實際取色、像素字型、事實限制 | `00-素材與規則.md` |
| 1 | 三家**獨立**提出完整設計 | `r1-claude.md`、`r1-codex.md`、`r1-gemini.md` |
| 2 | 讀完彼此的提案後切磋：採納、反對、回答彼此的問題 | `r2-*.md` |
| 3 | Claude 統整設計決議（每條標出處）→ 兩家提最後異議 → 定案 | `r3-設計決議.md`、`r3-codex.md`、`r3-gemini.md` |
| 4 | Codex 依決議實作 → Gemini 審查原始碼、Claude 在瀏覽器實測 | `gaiacraft-共同版-v1.html`、`r4-gemini-審查.md`、`r4-claude-審查.md` |
| 5 | Codex 依兩份審查修改 → Claude 再實測 | `r5-codex-修改說明.md`、`gaiacraft-共同版.html` |

## 討論中真正改變了結果的地方
- **隱喻收斂**：Claude 與 Gemini 第 1 輪**各自**提出「游泳隊 × 下潛」；Codex 提「記憶接力」。第 2 輪 Codex 改採下潛，「接力」保留在結尾的合作區。
- **首屏被 Codex 說服**：Claude 原本用 PRESS START 標題畫面開場，Codex 主張「永安實景 × 遊戲同框」才是證據。Claude 與 Gemini 第 2 輪都採納。
- **政大百年的位置由 Gemini 解決**：Claude 擔心百年被壓成開頭一小段，Gemini 提出「浮出水面回到政大」當結局。
- **THE PARTY 的位置二比一**：Claude 放在前面，Codex 與 Gemini 都反對（「還不知道作品前，不會想先看學生名字」），移到合作區前。
- **事實界線**：Claude 抓出 Gemini 自編的長輩台詞與 -45m 水深數字，以及第 2 輪的「四條記憶支線」；Gemini 撤回，三家定下「網站上不能有看起來像長輩說的、其實是我們寫的句子」。
- **Gemini 的兩條異議被採納**：章名不跳號（改用旅程名稱）、收集冊空格只留 2 格。
- **審查分工互補**：Gemini 看原始碼抓出字體與禁用清單違規；Claude 在瀏覽器實測抓出首屏留白、截圖被裁成直條、手機看不到同框這些只有看畫面才知道的問題。

## 風格分數（Gemini 審查 v1）
上一輪各自做的 demo：A 3.5／B 4.5／C 2.5 → 共同版 v1：7.2（v2 修正了 Gemini 列出的全部 6 條與 Claude 的 4 條）

## 怎麼看
在 `AI 協作` 資料夾執行 `python3 -m http.server 8790`，打開
`http://localhost:8790/gaiacraft 企劃/05-共同設計/gaiacraft-共同版.html`
