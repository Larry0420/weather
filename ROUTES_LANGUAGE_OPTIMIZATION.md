# Routes 頁面語言優化總結

## 優化目標
優化 Routes 頁面中的選擇標籤，使其能夠根據 Settings 中選擇的語言顯示翻譯後的文字。

## 已完成的優化

### 1. 新增翻譯標籤
在 `LanguageProvider` 中添加了以下新的翻譯標籤：

```dart
String get selectDistrictDescription => _isEnglish ? 'Choose a district to view available routes' : '選擇一個地區來查看可用的路線';
String get selectRouteDescription => _isEnglish ? 'Choose a route to view schedule information' : '選擇一條路線來查看班次信息';
String get noScheduleDataDescription => _isEnglish ? 'No schedule data found for this route' : '沒有找到該路線的班次信息';
String get noTrainsDescription => _isEnglish ? 'No trains available for this route' : '該路線目前沒有班次信息';
```

### 2. 優化空狀態視圖
為 Routes 頁面的各個空狀態添加了描述性文字：

- **選擇地區空狀態**：添加了 `lang.selectDistrictDescription` 描述文字
- **選擇路線空狀態**：添加了 `lang.selectRouteDescription` 描述文字
- **無班次數據空狀態**：添加了 `lang.noScheduleDataDescription` 描述文字
- **無列車空狀態**：添加了 `lang.noTrainsDescription` 描述文字

### 3. 已存在的翻譯支持
以下組件已經正確實現了翻譯支持：

- **`AdaptiveIndexPicker`**：地區和路線選擇器標籤
- **`_RouteSchedulesList`**：路線標題、服務車站數量
- **車站卡片**：車站名稱、列車數量、到達/開出時間
- **列車信息**：目的地、列車長度、服務狀態
- **錯誤提示**：未匹配車站警告

### 4. 翻譯標籤使用情況

#### 主要標籤
- `lang.selectDistrict`：選擇地區
- `lang.selectRoute`：選擇路線
- `lang.route`：路線
- `lang.stationsServed`：服務車站
- `lang.unmatchedStations`：未對應車站

#### 狀態標籤
- `lang.noData`：沒有資料
- `lang.noTrains`：沒有即將到達的列車
- `lang.cars`：卡
- `lang.arrives`：到達
- `lang.departs`：開出
- `lang.serviceStopped`：服務暫停

#### 新增描述標籤
- `lang.selectDistrictDescription`：選擇地區的描述
- `lang.selectRouteDescription`：選擇路線的描述
- `lang.noScheduleDataDescription`：無班次數據的描述
- `lang.noTrainsDescription`：無列車的描述

## 優化效果

1. **一致性**：所有 Routes 頁面的文字現在都使用統一的翻譯系統
2. **用戶體驗**：用戶在 Settings 中切換語言後，Routes 頁面的所有文字都會即時更新
3. **信息豐富**：空狀態視圖現在提供更詳細的描述，幫助用戶理解當前狀態
4. **完整性**：涵蓋了選擇、狀態顯示、錯誤處理等所有用戶界面元素

## 測試建議

1. 在 Settings 中切換語言（英文 ↔ 繁體中文）
2. 檢查 Routes 頁面的以下元素是否正確翻譯：
   - 地區和路線選擇器標籤
   - 空狀態視圖的標題和描述
   - 路線標題和服務車站信息
   - 車站卡片和列車信息
   - 未匹配車站警告

## 技術實現

- 使用 `context.watch<LanguageProvider>()` 監聽語言變化
- 通過 `lang.isEnglish` 判斷當前語言
- 使用 `lang.xxx` 獲取翻譯後的文字
- 所有翻譯標籤都支持英文和繁體中文
- 空狀態視圖使用兩層文字結構：標題 + 描述

## 用戶界面改進

### 空狀態視圖優化
- **之前**：只顯示圖標和標題
- **現在**：顯示圖標、標題和描述性文字
- **效果**：用戶能更好地理解當前狀態和下一步操作

### 翻譯一致性
- **之前**：部分文字使用硬編碼
- **現在**：所有文字都使用翻譯系統
- **效果**：語言切換時所有文字都能正確更新
