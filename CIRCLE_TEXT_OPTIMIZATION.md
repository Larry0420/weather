# 圓圈文字優化 - 自適應文字大小

## 問題描述
在 Schedules 頁面中，圓圈內的路線號碼文字可能會因為內容過長而超出圓圈邊界，影響視覺效果和可讀性。

## 解決方案

### 1. 創建自適應圓圈文字組件
創建了 `AdaptiveCircleText` 組件，提供以下功能：
- 自動縮放文字以適應圓圈大小
- 支持自定義圓圈大小、顏色和邊框
- 內建文字居中對齊
- 支持無障礙訪問的文字縮放

### 2. 使用 `FittedBox` 實現自適應縮放
- `fit: BoxFit.scaleDown` - 當文字超出容器時自動縮小
- 保持文字比例不變
- 確保文字始終在圓圈內顯示

### 3. 添加內邊距保護
- 在文字周圍添加 4px 的內邊距
- 防止文字貼近圓圈邊緣
- 提升視覺效果

## 組件實現

### `AdaptiveCircleText` 組件
```dart
class AdaptiveCircleText extends StatelessWidget {
  final String text;
  final double circleSize;
  final double baseFontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(circleSize / 2),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: baseFontSize,
                fontWeight: fontWeight,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
```

## 使用示例

### Schedules 頁面中的應用

#### 1. **路線號碼圓圈（詳細視圖）**
```dart
AdaptiveCircleText(
  text: train.routeNo,
  circleSize: 48,
  baseFontSize: 16 * accessibility.textScale,
  textColor: train.isStopped 
      ? Colors.red
      : Theme.of(context).colorScheme.onSecondaryContainer,
  backgroundColor: train.isStopped 
      ? Colors.red.withValues(alpha: 0.1)
      : Theme.of(context).colorScheme.secondaryContainer,
  borderColor: train.isStopped 
      ? Colors.red.withValues(alpha: 0.3)
      : Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
)
```

#### 2. **平台號碼圓圈**
```dart
AdaptiveCircleText(
  text: '${platform.platformId}',
  circleSize: 40,
  baseFontSize: 14 * accessibility.textScale,
  textColor: Theme.of(context).colorScheme.onPrimaryContainer,
  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
  borderColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
)
```

#### 3. **路線號碼圓圈（列表視圖）**
```dart
AdaptiveCircleText(
  text: train.routeNo.isEmpty ? '?' : train.routeNo,
  circleSize: 40,
  baseFontSize: 14 * accessibility.textScale,
  textColor: color,
  backgroundColor: color.withValues(alpha: 0.15),
  borderColor: color.withValues(alpha: 0.5),
  borderWidth: 1.5,
)
```

## 優化效果

### ✅ **改進前**
- 文字可能超出圓圈邊界
- 需要手動調整字體大小
- 不同長度的文字顯示不一致

### ✅ **改進後**
- 文字自動縮放以適應圓圈
- 保持視覺一致性
- 支持任意長度的文字
- 提升用戶體驗

## 技術特點

### 1. **自適應縮放**
- 使用 `FittedBox` 實現自動縮放
- 保持文字比例和可讀性
- 無需手動計算字體大小

### 2. **靈活配置**
- 支持自定義圓圈大小
- 可配置顏色、邊框和字體
- 支持無障礙訪問縮放

### 3. **視覺優化**
- 內建文字居中對齊
- 添加內邊距保護
- 圓形邊框設計

## 適用場景
- 圓圈內顯示數字或短文字
- 需要自適應文字大小的 UI 元素
- 保持視覺一致性的設計需求

## 在 Schedules 頁面的完整應用

### ✅ **已優化的圓圈**
1. **平台號碼圓圈** - 顯示平台編號（如：1、2）
2. **路線號碼圓圈（列表視圖）** - 顯示路線編號（如：70）
3. **路線號碼圓圈（詳細視圖）** - 顯示路線編號（如：70）

### 🎯 **優化效果**
- 所有圓圈文字都會自動縮放以適應圓圈大小
- 支持不同長度的數字和文字
- 保持視覺一致性和可讀性
- 提升整體用戶體驗

## 總結
通過創建 `AdaptiveCircleText` 組件，成功解決了圓圈內文字溢出的問題。該組件提供了自適應的文字縮放功能，確保文字始終在圓圈內正確顯示，同時保持了良好的視覺效果和用戶體驗。
