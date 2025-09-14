# Schedule 頁面語言優化總結

## 優化目標
優化 Schedule 頁面中的選擇標籤，使其能夠根據 Settings 中選擇的語言顯示翻譯後的文字。

## 已完成的優化

### 1. 新增翻譯標籤
在 `LanguageProvider` 中添加了以下新的翻譯標籤：

```dart
String get searchStations => _isEnglish ? 'Search stations...' : '搜尋車站...';
String get recent => _isEnglish ? 'Recent' : '最近使用';
String get noStationsFound => _isEnglish ? 'No stations found' : '找不到車站';
```

### 2. 更新 _OptimizedStationSelector 組件
將硬編碼的文字替換為翻譯標籤：

- **搜索框提示文字**：`widget.isEnglish ? 'Search stations...' : '搜尋車站...'` → `lang.searchStations`
- **最近使用標籤**：`widget.isEnglish ? 'Recent' : '最近使用'` → `lang.recent`
- **無結果提示**：`widget.isEnglish ? 'No stations found' : '找不到車站'` → `lang.noStationsFound`

### 3. 已存在的翻譯支持
以下組件已經正確實現了翻譯支持：

- **`_StatusBar`**：系統狀態、正常/警示、最後更新時間
- **`_ErrorView`**：離線提示、網絡錯誤、重試按鈕
- **`_PlatformCard`**：月台標籤、無列車提示
- **`_TrainTile`**：到達/開出、列車長度
- **`_TrainDetail`**：目的地、月台、時間、狀態等詳細信息
- **`SimpleStationSelector`**：選擇車站標題

### 4. 車站分組翻譯
車站分組已經正確實現了中英文翻譯：

```dart
String _getStationGroup(int stationId) {
  if (stationId <= 100) return '屯門碼頭區';
  if (stationId <= 200) return '屯門北區';
  // ... 其他分組
}

String _getStationGroupEn(int stationId) {
  if (stationId <= 100) return 'Tuen Mun Ferry Pier';
  if (stationId <= 200) return 'Tuen Mun North';
  // ... 其他分組
}
```

## 優化效果

1. **一致性**：所有 Schedule 頁面的文字現在都使用統一的翻譯系統
2. **用戶體驗**：用戶在 Settings 中切換語言後，Schedule 頁面的所有文字都會即時更新
3. **維護性**：所有翻譯文字集中在 `LanguageProvider` 中管理，便於維護和擴展
4. **完整性**：涵蓋了搜索、選擇、狀態顯示、錯誤處理等所有用戶界面元素

## 測試建議

1. 在 Settings 中切換語言（英文 ↔ 繁體中文）
2. 檢查 Schedule 頁面的以下元素是否正確翻譯：
   - 車站選擇器的搜索框提示
   - 最近使用車站標籤
   - 無搜索結果提示
   - 車站分組名稱
   - 所有狀態和錯誤信息

## 技術實現

- 使用 `context.watch<LanguageProvider>()` 監聽語言變化
- 通過 `lang.isEnglish` 判斷當前語言
- 使用 `lang.xxx` 獲取翻譯後的文字
- 所有翻譯標籤都支持英文和繁體中文
