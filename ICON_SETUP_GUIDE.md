# 電車圖示設置指南

## 概述
本指南將幫助您為 LRT Next Train 應用程式設置電車圖示。

## 步驟 1: 準備圖示檔案
您需要準備一個 1024x1024 像素的 PNG 格式電車圖示檔案，並將其命名為 `tram_icon.png`。

## 步驟 2: 放置圖示檔案
將 `tram_icon.png` 檔案放置在以下位置：
```
assets/icon/tram_icon.png
```

## 步驟 3: 生成應用程式圖示
運行以下命令來生成所有平台的圖示：
```bash
flutter pub run flutter_launcher_icons:main
```

## 步驟 4: 清理臨時檔案
生成完成後，您可以刪除以下臨時檔案：
- `generate_icon.dart`
- `create_icon.dart`
- `tools/generate_icon.dart`
- `lib/icon_generator.dart`

## 圖示設計建議
- 使用藍色和橙色主題色彩
- 包含電車元素（車身、車窗、輪子）
- 添加 "LRT" 文字標識
- 確保在不同尺寸下都清晰可見

## 故障排除
如果遇到問題：
1. 確保圖示檔案存在且格式正確
2. 檢查檔案路徑是否正確
3. 確保 Flutter 環境已正確設置
4. 運行 `flutter clean` 後重試

## 完成
完成後，您的應用程式將在所有平台上顯示電車圖示。
