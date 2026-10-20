# Claude 審查（瀏覽器實測 1280 與 375）
- 通過：段落順序符合決議；兩種寬度皆無溢出、無破圖；CH03 預設展開；送出鈕 disabled；載入時 0 個 YouTube iframe。
- 問題：手機用的「看前／看後」切換鈕在 1280 桌機也顯示（決議只在 <720px 出現，桌機用拖曳）。
- 認錯：「木柵、石碇的在地茶文化」是 Claude 在 demo-B 自己加的地名，原站沒有，同意 Gemini 移除。
- Gemini 5 條全部採納。其中「.history-part > h3 加英文 kicker」：可加，沿用 demo-B 既有的 .kicker 樣式即可（例：ORIGIN／JOURNEY／RETURN）。
