# Schedules 頁面統一變數優化

## 概述

本次優化針對 Schedules、Routes 和 Settings 頁面中的樣式定義進行了統一變數重構，將重複的樣式定義整合到 `UIConstants` 類中，提高了代碼的可維護性和一致性。

## 優化內容

### 1. 新增統一變數

在 `UIConstants` 類中新增了以下統一變數：

#### 字體大小常數
```dart
static const double fontSizeXS = 11.0;
static const double fontSizeS = 12.0;
static const double fontSizeM = 14.0;
static const double fontSizeL = 16.0;
static const double fontSizeXL = 18.0;
static const double fontSizeXXL = 20.0;
```

#### 圓圈大小常數
```dart
static const double circleSizeS = 48.0;
static const double circleSizeM = 64.0;
```

#### 間距常數
```dart
static const EdgeInsets scheduleCardMargin = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
static const EdgeInsets scheduleCardPadding = EdgeInsets.all(16);
static const EdgeInsets scheduleBadgePadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
static const EdgeInsets scheduleListTilePadding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
static const EdgeInsets scheduleSubtitlePadding = EdgeInsets.only(top: 4);
```

#### 圓角常數
```dart
static const double scheduleCardBorderRadius = 16.0;
static const double scheduleBadgeBorderRadius = 12.0;
static const double scheduleIconBorderRadius = 12.0;
```

### 2. 統一樣式方法

#### 文字樣式方法
- `scheduleTitleStyle()` - 標題樣式
- `scheduleSubtitleStyle()` - 副標題樣式
- `scheduleBodyStyle()` - 正文樣式
- `scheduleCaptionStyle()` - 說明文字樣式
- `scheduleErrorStyle()` - 錯誤文字樣式
- `scheduleRouteHeaderStyle()` - 路線標題樣式
- `scheduleStationNameStyle()` - 車站名稱樣式
- `scheduleTrainNameStyle()` - 列車名稱樣式
- `scheduleBadgeStyle()` - 徽章樣式
- `scheduleNoDataStyle()` - 無數據樣式

#### 佈局樣式方法
- `scheduleCardShadow()` - 卡片陰影
- `scheduleCardBorder()` - 卡片邊框
- `scheduleListTileBorder()` - 列表項邊框
- `scheduleHeaderBackground()` - 標題背景色
- `scheduleErrorBackground()` - 錯誤背景色
- `scheduleErrorBorder()` - 錯誤邊框色

#### 圖標和組件方法
- `scheduleIconSize()` - 圖標大小
- `scheduleLargeIconSize()` - 大圖標大小
- `scheduleCircleText()` - 圓圈文字組件

### 3. 優化的組件

#### _RouteSchedulesList 類
- 統一了所有文字樣式定義
- 統一了間距和圓角定義
- 統一了陰影和邊框定義
- 統一了圖標大小定義
- 統一了圓圈文字組件配置

## Routes 頁面優化

### 新增 Routes 頁面統一變數

#### 間距常數
```dart
static const EdgeInsets routesSelectorMargin = EdgeInsets.fromLTRB(12, 8, 12, 8);
static const EdgeInsets routesSelectorPadding = EdgeInsets.all(12);
static const EdgeInsets routesChipPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 6);
static const EdgeInsets routesCompactChipPadding = EdgeInsets.symmetric(horizontal: 6, vertical: 4);
static const EdgeInsets routesWarningPadding = EdgeInsets.all(16);
static const EdgeInsets routesWarningChipPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 6);
```

#### 圓角常數
```dart
static const double routesSelectorBorderRadius = 12.0;
static const double routesWarningBorderRadius = 12.0;
static const double routesWarningChipBorderRadius = 16.0;
```

#### Routes 頁面樣式方法
- `routesLabelStyle()` - 標籤樣式
- `routesDistrictChipStyle()` - 地區選擇器樣式
- `routesRouteChipStyle()` - 路線選擇器樣式
- `routesDescriptionStyle()` - 描述文字樣式
- `routesWarningTitleStyle()` - 警告標題樣式
- `routesWarningChipStyle()` - 警告徽章樣式

#### Routes 頁面佈局方法
- `routesSelectorShadow()` - 選擇器陰影
- `routesSelectorBorder()` - 選擇器邊框
- `routesWarningBorder()` - 警告邊框
- `routesWarningChipBorder()` - 警告徽章邊框
- `routesWarningBackground()` - 警告背景色
- `routesWarningIconSize()` - 警告圖標大小

### 優化的 Routes 組件

#### _RoutesPageState 類
- 統一了選擇器容器的樣式定義
- 統一了標籤和描述文字樣式
- 統一了選擇器芯片的樣式
- 統一了警告提示的樣式
- 統一了間距和圓角定義

## Settings 頁面優化

### 新增 Settings 頁面統一變數

#### 間距常數
```dart
static const EdgeInsets settingsPagePadding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
static const EdgeInsets settingsSliderPadding = EdgeInsets.symmetric(horizontal: 16);
static const EdgeInsets settingsChoiceChipPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
```

#### 圓角常數
```dart
static const double settingsChoiceChipBorderRadius = 16.0;
```

#### Settings 頁面樣式方法
- `settingsCardTitleStyle()` - 卡片標題樣式
- `settingsCardSubtitleStyle()` - 卡片副標題樣式
- `settingsSectionTitleStyle()` - 區段標題樣式
- `settingsSliderLabelStyle()` - 滑塊標籤樣式
- `settingsChoiceChipLabelStyle()` - 選擇器標籤樣式

#### Settings 頁面圖標方法
- `settingsIconSize()` - 圖標大小
- `settingsLargeIconSize()` - 大圖標大小

### 優化的 Settings 組件

#### _SettingsPage 類
- 統一了卡片組件的樣式定義
- 統一了區段標題樣式
- 統一了滑塊和選擇器的樣式
- 統一了圖標大小定義
- 統一了間距定義

## 優化效果

### 代碼可維護性提升
- 消除了重複的樣式定義
- 統一了樣式命名規範
- 提高了樣式修改的效率

### 一致性改善
- 所有文字大小使用統一的常數
- 所有間距使用統一的常數
- 所有圓角使用統一的常數
- 所有顏色使用統一的方法

### 可擴展性增強
- 新增樣式只需在 `UIConstants` 中定義
- 修改樣式只需修改對應的方法
- 支持無障礙功能的統一配置

## 使用示例

### 之前的寫法
```dart
Text(
  stationName,
  style: TextStyle(
    fontSize: 16 * accessibility.textScale,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).brightness == Brightness.dark 
        ? Colors.white.withValues(alpha: 0.87)
        : null,
  ),
)
```

### 優化後的寫法
```dart
Text(
  stationName,
  style: UIConstants.scheduleStationNameStyle(context, accessibility),
)
```

## 注意事項

1. 所有樣式方法都需要傳入 `context` 和 `accessibility` 參數
2. 圓圈文字組件使用統一的配置方法
3. 圖標大小支持自定義倍數參數
4. 所有樣式都支持無障礙功能的自動縮放

## 未來擴展

- 可以為其他頁面創建類似的統一變數
- 可以進一步抽象通用的樣式組件
- 可以創建主題相關的樣式變數
