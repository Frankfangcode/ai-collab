### 1. 違反決議之處
* **字體用途違規**：
  * **缺漏**：決議規定「章名」須用 `Cubic 11`，但所有 `h2`（如 `#shore-title`、`#yongan-title` 等旅程大標）皆繼承了 `body` 的 `Noto Sans TC`。
  * **缺漏**：收集冊已解鎖格子的標題 `.collect-item strong` 未套用 `var(--font-pixel)`（僅 `.locked` 有套用）。
  * **超用**：`.hero-pair::after`（「同一個村口」）與 `.lane span:first-child`（「泳道 A/B/C」）使用了 `var(--font-pixel)`，不在決議允許的五項範圍內。
* **禁用清單違規**：
  * `#party-title` 寫成「`THE PARTY・游泳隊出發`」，違反**禁用全大寫英文 kicker** 與**大標改用旅程名稱**的修正案（`CHAPTER 0X` 已退居小標，但 `THE PARTY` 仍殘留在大標）。
* **色票與明暗微瑕**：
  * `.shore`（`#ebe5d4`）與 `.memory`（`#e8e3cf`）自行調配了色票外的灰米色；`.relay`（接力）用了深綠底 `var(--campus)`，削弱了「浮出後回到 `#F6F1DF`（淺）」的收尾明暗對比。
* **段落順序與事實界線**：100% 符合決議，語錄與 3D 狀態皆嚴守〔待填〕。

### 2. 殘留的「AI 範本味」
* **SaaS 懸浮導覽列**：`.journey` 使用 `box-shadow: 0 8px 22px #17262d1c` 搭配白底細框，像現代後台 UI，缺乏田野日誌或遊戲介面感。
* **Bento Grid 資訊卡**：`.collection` 的 `repeat(2, 1fr)` 等高白底卡片配頂部 1px 細線，像極了 SaaS 功能列表，沒有「收集冊／圖鑑格子」的裝幀感。
* **現代雙欄對稱排版**：`.hero-grid` 與 `.shore-layout` 仍是標準 AI 產出的「左文右圖」對稱網格。

### 3. 具體修改指令（供 Codex 直接執行）
1. **章名補上像素字體**：在 CSS 的 `h2` 規則加上 `font-family: var(--font-pixel); font-weight: 400; letter-spacing: .02em;`。
2. **移除大標全大寫英文**：將 `#party-title` 文字改為「`游泳隊出發`」，並在上方新增 `<p class="line-label">THE PARTY</p>`（或直接捨棄英文）。
3. **修正收集冊字體與格子感**：將 `.collect-item` 的 `border-top: 1px solid var(--campus)` 改為 `border: 2px solid var(--silt)`，並為 `.collect-item strong` 加上 `font-family: var(--font-pixel); font-weight: 400;`。
4. **收斂超用的像素字體**：將 `.hero-pair::after` 與 `.lane span:first-child` 的 `var(--font-pixel)` 改為 `var(--font-body)` 與 `font-weight: 700`。
5. **消除導覽列 SaaS 浮空陰影**：將 `.journey` 的 `box-shadow` 改為 `4px 4px 0 var(--ink)`，邊框改為 `2px solid var(--ink)`。
6. **統一淺色區色票**：將 `.shore` 與 `.memory` 的 `background` 改回 `var(--paper)`，區隔改用 `border-top: 1px solid var(--silt)`，不自創灰米色。

### 4. 「自己的風格」評分：**7.2 / 10**
相比上一輪（3.5／4.5／2.5），這版徹底拔除了毛玻璃、發光圓角與顧問排比句，實景與像素對照、水面線轉場與誠實的〔待填〕標記讓網站長出了真實的學生田野骨肉；只要把 `h2` 字體、收集冊邊框與陰影修正到位，就能突破 8 分。
