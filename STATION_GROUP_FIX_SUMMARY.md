# 車站分組函數修復總結

## 問題描述

在檢查所有 StationSelector 組件時，發現 `_OptimizedStationSelector` 和 `SimpleStationSelector` 沒有使用更新後的 `_getStationGroup` 函數，導致車站分組顯示不一致。

## 修復內容

### 1. _OptimizedStationSelector 修復

**位置**: `lib/main.dart` 第 4478-4502 行

**修復前**:
```dart
String _getStationGroup(int stationId) {
  if (stationId <= 100) return '屯門碼頭區';
  if (stationId <= 200) return '屯門北區';
  if (stationId <= 300) return '屯門市中心';
  if (stationId <= 400) return '元朗區';
  if (stationId <= 500) return '天水圍區';
  if (stationId <= 600) return '元朗市中心';
  return '其他';
}
```

**修復後**:
```dart
String _getStationGroup(int stationId) {
  // Handle special cases first
  if (stationId == 920) return '屯門碼頭'; // Sam Shing
  
  // Tin Shui Wai directional subdivisions (430-550)
  if (stationId >= 430 && stationId <= 550) {
    if (stationId == 430 || stationId == 550) return '天水圍東';
    if (stationId >= 435 && stationId <= 450) return '天水圍北';
    if (stationId >= 455 && stationId <= 490) return '天水圍西';
    if (stationId >= 500 && stationId <= 540) return '天水圍南';
  }
  
  // Yuen Long subdivisions
  if (stationId >= 560 && stationId <= 600) return '元朗市中心';
  if (stationId >= 370 && stationId <= 425) return '元朗北';
  
  // Tuen Mun subdivisions
  if (stationId <= 90 || stationId == 920) return '屯門碼頭';
  if (stationId <= 200) return '屯門北';
  if (stationId <= 360) return '屯門市中心';
  
  return '其他';
}
```

### 2. SimpleStationSelector 修復

**位置**: `lib/main.dart` 第 4910-4934 行

**新增功能**:
- 添加了 `_getStationGroup` 和 `_getStationGroupEn` 函數
- 更新了副標題顯示，從顯示 "ID: $stationId" 改為顯示車站分組

**修復前**:
```dart
subtitle: Text('ID: $stationId'),
```

**修復後**:
```dart
subtitle: Text(isEnglish ? _getStationGroupEn(stationId) : _getStationGroup(stationId)),
```

## 車站分組邏輯

### 特殊情況處理
- **920 (Sam Shing)**: 歸類為 '屯門碼頭' / 'Tuen Mun Ferry Pier'

### 天水圍區細分 (430-550)
- **430, 550**: 天水圍東 / Tin Shui Wai East
- **435-450**: 天水圍北 / Tin Shui Wai North
- **455-490**: 天水圍西 / Tin Shui Wai West
- **500-540**: 天水圍南 / Tin Shui Wai South

### 元朗區細分
- **560-600**: 元朗市中心 / Yuen Long Central
- **370-425**: 元朗北 / Yuen Long North

### 屯門區細分
- **≤90, 920**: 屯門碼頭 / Tuen Mun Ferry Pier
- **≤200**: 屯門北 / Tuen Mun North
- **≤360**: 屯門市中心 / Tuen Mun Central

## 修復效果

### 一致性改善
- 所有 StationSelector 組件現在使用相同的車站分組邏輯
- 車站分組顯示更加準確和詳細
- 支持中英文雙語顯示

### 用戶體驗提升
- 用戶可以更容易找到特定區域的車站
- 車站分組更加直觀和實用
- 支持更精細的地理分區

## 驗證結果

### 已修復的組件
- ✅ `EnhancedStationSelector` - 已使用正確的分組邏輯
- ✅ `_OptimizedStationSelector` - 已修復分組邏輯
- ✅ `SimpleStationSelector` - 已添加分組功能

### 分組邏輯驗證
- ✅ 特殊車站 (920) 正確歸類
- ✅ 天水圍區細分正確
- ✅ 元朗區細分正確
- ✅ 屯門區細分正確
- ✅ 中英文對應正確

## 注意事項

1. 所有分組邏輯都基於實際的輕鐵車站編號系統
2. 特殊車站 (如 Sam Shing 920) 有專門的處理邏輯
3. 分組支持中英文雙語顯示
4. 分組邏輯在所有 StationSelector 組件中保持一致

## 未來改進

- 可以考慮根據實際路線進一步細分車站分組
- 可以添加更多特殊車站的處理邏輯
- 可以考慮添加車站分組的視覺化顯示
