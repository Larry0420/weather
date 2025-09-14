# Routes 快取功能測試指南

## 測試步驟

### 1. 基本快取測試

1. **啟動應用**
   - 運行 `flutter run --debug`
   - 確保應用正常啟動

2. **選擇地區和路線**
   - 進入 Routes 頁面
   - 選擇一個地區（例如：屯門）
   - 選擇一條路線（例如：505）
   - 確認路線數據正常加載

3. **檢查快取保存**
   - 進入 Settings 頁面
   - 查看 "快取測試" 卡片
   - 點擊刷新按鈕查看調試信息
   - 確認 `hasUserSelection` 為 `true`

4. **測試快取恢復**
   - 關閉應用（完全退出）
   - 重新啟動應用
   - 進入 Routes 頁面
   - 確認之前選擇的地區和路線自動恢復
   - 確認路線數據自動加載

### 2. 調試信息檢查

在 Settings 頁面的 "快取測試" 卡片中，點擊刷新按鈕會顯示以下調試信息：

```
=== 快取測試按鈕被點擊 ===
districtIndex: [選擇的地區索引]
routeIndex: [選擇的路線索引]
selectedDistrict: [地區名稱]
selectedRoute: [路線編號]
hasUserSelection: [是否為用戶選擇]
```

### 3. 控制台日誌檢查

在調試模式下，查看控制台輸出中的以下日誌：

#### 保存選擇時：
```
RoutesCatalogProvider.setDistrictIndex: saved districtIndex=X, routeIndex=0, hasUserSelected=true
RoutesCatalogProvider.setRouteIndex: saved routeIndex=X, hasUserSelected=true
```

#### 恢復選擇時：
```
RoutesCatalogProvider._restore: districtIndex=X, routeIndex=X, hasUserSelected=true
RoutesCatalogProvider.hasUserSelection: true && true && true = true
_RoutesPage.initState: hasUserSelection=true
_RoutesPage.initState: Loading cached route data
```

### 4. 預期行為

#### 正常情況：
- 選擇地區和路線後，設置會立即保存
- 重新啟動應用後，選擇會自動恢復
- Routes 頁面會自動加載對應的路線數據
- Settings 頁面的快取測試卡片顯示正確的選擇信息

#### 異常情況：
- 如果 `hasUserSelection` 為 `false`，檢查 `_hasUserSelected` 是否正確保存
- 如果選擇沒有恢復，檢查 SharedPreferences 是否正常工作
- 如果數據沒有加載，檢查網絡連接和 API 響應

### 5. 故障排除

#### 問題：選擇沒有被保存
**解決方案：**
- 檢查 `setDistrictIndex` 和 `setRouteIndex` 方法是否被正確調用
- 確認 SharedPreferences 權限正常
- 查看控制台是否有錯誤信息

#### 問題：選擇沒有恢復
**解決方案：**
- 檢查 `_restore` 方法是否正確執行
- 確認 `_hasUserSelected` 標記是否正確保存
- 驗證索引值是否在有效範圍內

#### 問題：數據沒有自動加載
**解決方案：**
- 檢查 `_loadForRouteIfNeeded` 方法是否被調用
- 確認網絡連接正常
- 查看 API 響應是否正常

### 6. 測試場景

#### 場景 1：首次使用
- 新安裝的應用
- 預期：沒有保存的選擇，需要手動選擇

#### 場景 2：正常使用
- 選擇地區和路線
- 關閉並重新啟動應用
- 預期：選擇自動恢復，數據自動加載

#### 場景 3：切換選擇
- 已有保存的選擇
- 選擇新的地區和路線
- 預期：新選擇覆蓋舊選擇

#### 場景 4：無效選擇
- 保存的索引超出範圍
- 預期：自動重置為默認選擇

### 7. 性能測試

#### 並行加載測試：
- 選擇包含多個車站的路線
- 觀察數據加載速度
- 預期：並行加載比串行加載更快

#### 快取效率測試：
- 重複選擇相同路線
- 觀察是否使用快取數據
- 預期：快取數據優先使用

## 注意事項

1. **調試模式**：確保在調試模式下運行以查看詳細日誌
2. **網絡連接**：測試時確保網絡連接正常
3. **權限**：確保應用有 SharedPreferences 讀寫權限
4. **數據一致性**：檢查保存和恢復的數據是否一致

## 成功標準

快取功能正常工作時，應該滿足以下標準：

1. ✅ 用戶選擇能夠立即保存
2. ✅ 應用重啟後選擇自動恢復
3. ✅ 路線數據自動加載
4. ✅ 調試信息顯示正確
5. ✅ 性能優化生效
6. ✅ 錯誤處理正常

如果所有標準都滿足，則快取功能實現成功！
