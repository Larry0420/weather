# Routes 頁面選擇器緊湊佈局優化

## 優化目標
優化路線頁面中選擇器組件的邊距和佈局，實現緊湊而高效的設計，提升空間利用率。

## 主要改進

### 1. 整體容器優化
**之前**：簡單的 Padding 包裝
**現在**：緊湊的卡片式容器設計

```dart
// 優化前
Padding(
  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
  child: Row(...),
)

// 優化後 - 緊湊設計
Container(
  margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.03),
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
    ],
    border: Border.all(
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.08),
      width: 0.5,
    ),
  ),
  child: Row(...),
)
```

### 2. 間距優化

#### 標籤間距
- **之前**：`SizedBox(height: 16)`
- **現在**：`SizedBox(height: 8)` - 極致緊湊的佈局

#### 選擇器間距
- **之前**：`SizedBox(width: 16)`
- **現在**：`SizedBox(width: 12)` - 緊湊的視覺分離

#### 選項間距
- **之前**：`spacing: 8.0, runSpacing: 4.0`
- **現在**：`spacing: 4.0, runSpacing: 4.0` - 緊湊均勻的分佈

### 3. ChoiceChip 樣式優化

#### 地區選擇器
```dart
ChoiceChip(
  label: Text(
    districtNames[i],
    style: TextStyle(
      fontSize: 12,
      fontWeight: i == safeIndex ? FontWeight.w600 : FontWeight.w500,
    ),
  ),
  selectedColor: Theme.of(context).colorScheme.primaryContainer,
  backgroundColor: Theme.of(context).colorScheme.surface,
  side: BorderSide(
    color: i == safeIndex 
      ? Theme.of(context).colorScheme.primary
      : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
    width: 0.5,
  ),
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
)
```

#### 路線選擇器
```dart
ChoiceChip(
  label: Text(
    routeLabels[i],
    style: TextStyle(
      fontSize: 11,
      fontWeight: i == safeIndex ? FontWeight.w600 : FontWeight.w500,
    ),
  ),
  selectedColor: Theme.of(context).colorScheme.secondaryContainer,
  backgroundColor: Theme.of(context).colorScheme.surface,
  side: BorderSide(
    color: i == safeIndex 
      ? Theme.of(context).colorScheme.secondary
      : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
    width: 0.5,
  ),
  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
)
```

### 4. 容器包裝優化
為選項添加緊湊的容器包裝，提供更好的視覺層次：

```dart
Container(
  padding: const EdgeInsets.symmetric(vertical: 2),
  child: Wrap(
    spacing: 4.0,
    runSpacing: 4.0,
    children: [...],
  ),
)
```

## 視覺改進

### 層次感
- 卡片式背景提供清晰的視覺分離
- 柔和的陰影增加深度感
- 邊框提供精緻的邊界定義

### 間距平衡
- 外部邊距：12px 提供緊湊的呼吸空間
- 內部邊距：12px 確保內容緊湊排列
- 元素間距：4px 提供極致緊湊的佈局

### 色彩區分
- 地區選擇器：使用主色調
- 路線選擇器：使用次要色調
- 未選中狀態：使用中性色調

## 用戶體驗提升

### 視覺清晰度
- 更清晰的選項邊界
- 更好的選中狀態指示
- 更舒適的閱讀體驗

### 交互反饋
- 選中狀態的視覺強化
- 邊框顏色的動態變化
- 字體粗細的狀態區分

### 佈局優化
- 極致緊湊的空間利用
- 高效的視覺平衡
- 現代化的緊湊設計語言

## 技術特點

### 響應式設計
- 適應不同屏幕尺寸
- 支持主題色彩變化
- 保持一致的視覺風格

### 性能優化
- 使用 Material Design 組件
- 避免不必要的重繪
- 保持流暢的動畫效果

### 可訪問性
- 支持文字縮放
- 高對比度設計
- 清晰的視覺層次

這次優化讓選擇器組件實現了極致緊湊的設計，在保持功能性的同時最大化空間利用率，提供了高效的用戶體驗。
