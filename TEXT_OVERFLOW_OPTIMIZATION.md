# 文字溢出優化 - 防止換行

## 問題描述
在 Schedules 和 Routes 頁面中，某些文字可能會因為內容過長而換行到第二行，影響界面的整潔性和一致性。

## 優化方案

### 1. 使用 `TextOverflow.ellipsis`
- 當文字超出可用空間時，顯示省略號（...）
- 保持界面整潔，避免文字換行

### 2. 設置 `maxLines: 1`
- 限制文字最多顯示一行
- 確保所有文字元素保持一致的佈局

### 3. 使用 `Flexible` 組件
- 在 Row 中使用 `Flexible` 包裝文字
- 允許文字在可用空間內自適應

## 實施詳情

### Schedules 頁面優化

#### 1. **列車名稱標題**
```dart
Text(
  train.name(lang.isEnglish),
  style: TextStyle(...),
  overflow: TextOverflow.ellipsis,
  maxLines: 1,
)
```

#### 2. **時間信息**
```dart
Flexible(
  child: Text(
    '$ad: ${train.time(lang.isEnglish)}',
    style: TextStyle(...),
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
  ),
)
```

#### 3. **車廂數量信息**
```dart
Flexible(
  child: Text(
    '${train.trainLength ?? '?'} ${lang.cars}',
    style: TextStyle(...),
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
  ),
)
```

### Routes 頁面優化

#### 1. **路線標題**
```dart
Text(
  '${lang.route} $routeNo',
  style: TextStyle(...),
  overflow: TextOverflow.ellipsis,
  maxLines: 1,
)
```

#### 2. **車站數量信息**
```dart
Text(
  '${stationIds.length} ${lang.stationsServed}',
  style: TextStyle(...),
  overflow: TextOverflow.ellipsis,
  maxLines: 1,
)
```

## 優化效果

### ✅ **改進前**
- 文字可能換行到第二行
- 界面佈局不一致
- 影響視覺整潔性

### ✅ **改進後**
- 所有文字保持單行顯示
- 超出部分顯示省略號
- 界面佈局更加整潔一致
- 提升用戶體驗

## 技術實現

### 關鍵屬性
- `overflow: TextOverflow.ellipsis` - 顯示省略號
- `maxLines: 1` - 限制最大行數
- `Flexible` - 在 Row 中自適應空間

### 適用場景
- 列表項目的標題
- 副標題信息
- 任何需要保持單行顯示的文字

## 總結
通過添加 `overflow` 和 `maxLines` 屬性，成功解決了文字換行問題，提升了界面的整潔性和一致性。所有文字元素現在都保持單行顯示，超出部分會顯示省略號，確保了良好的用戶體驗。
