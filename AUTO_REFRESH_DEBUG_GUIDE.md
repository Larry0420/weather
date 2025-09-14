# 自動刷新調試指南

## 問題描述
自動刷新功能仍然不工作，需要添加詳細的調試信息來診斷問題。

## 添加的調試信息

### 1. StationProvider 調試
```dart
// 初始化時
debugPrint('=== StationProvider initialize called ===');
debugPrint('Saved station ID: $saved');
debugPrint('Restored station ID: $_selectedStationId, userHasSelected: $_userHasSelected');

// 設置車站時
debugPrint('=== setStation called for station $stationId ===');
debugPrint('Station set to: $_selectedStationId, userHasSelected: $_userHasSelected');
```

### 2. 自動刷新檢查調試
```dart
debugPrint('=== _checkAndStartAutoRefresh called ===');
debugPrint('Connectivity isOnline: ${connectivity.isOnline}');
debugPrint('Station userHasSelected: ${station.userHasSelected}');
debugPrint('Selected station ID: ${station.selectedStationId}');
debugPrint('Auto refresh active: ${sched.isAutoRefreshActive}');
```

### 3. 車站選擇調試
```dart
debugPrint('=== _selectStation called for station ${station.id} ===');
debugPrint('Connectivity isOnline: ${connectivity.isOnline}');
debugPrint('Loading data and starting auto-refresh for station ${station.id}');
```

### 4. 自動刷新啟動調試
```dart
debugPrint('=== startAutoRefresh called for station $stationId ===');
debugPrint('Using refresh interval: ${refreshInterval.inSeconds}s');
debugPrint('Auto-refresh started for station $stationId with interval: ${refreshInterval.inSeconds}s');
```

### 5. 數據加載調試
```dart
debugPrint('Loading data for station $stationId, forceRefresh: $forceRefresh');
debugPrint('Current station ID before load: $_currentStationId');
debugPrint('Setting current station ID to $stationId (no auto-refresh active)');
```

### 6. Timer觸發調試
```dart
debugPrint('Auto-refresh timer triggered for station $stationId');
debugPrint('Auto-refresh timer triggered for station $stationId (restarted)');
```

### 7. 手動控制調試
```dart
debugPrint('=== Manual refresh button pressed ===');
debugPrint('Current auto-refresh state: ${sched.isAutoRefreshActive}');
debugPrint('Selected station: ${station.selectedStationId}');
```

## 調試步驟

### 1. 啟動應用
查看控制台輸出：
- StationProvider初始化信息
- 是否有保存的車站ID
- 用戶是否已選擇車站

### 2. 選擇車站
查看控制台輸出：
- setStation調用信息
- _selectStation調用信息
- startAutoRefresh調用信息
- 數據加載信息

### 3. 等待自動刷新
查看控制台輸出：
- Timer觸發信息
- 數據加載信息
- 間隔調整信息

### 4. 手動控制
點擊刷新按鈕查看：
- 當前自動刷新狀態
- 啟動/停止操作

## 預期的調試輸出

### 正常啟動流程
```
=== StationProvider initialize called ===
Saved station ID: 1
Restored station ID: 1, userHasSelected: true
=== _checkAndStartAutoRefresh called ===
Connectivity isOnline: true
Station userHasSelected: true
Selected station ID: 1
Auto refresh active: false
Conditions met, checking if auto-refresh is not active
Starting auto-refresh for station 1
=== startAutoRefresh called for station 1 ===
Using refresh interval: 5s
Auto-refresh started for station 1 with interval: 5s
```

### 選擇車站流程
```
=== _selectStation called for station 1 ===
Connectivity isOnline: true
Loading data and starting auto-refresh for station 1
=== setStation called for station 1 ===
Station set to: 1, userHasSelected: true
Loading data for station 1, forceRefresh: false
=== startAutoRefresh called for station 1 ===
Using refresh interval: 5s
Auto-refresh started for station 1 with interval: 5s
```

### Timer觸發流程
```
Auto-refresh timer triggered for station 1
Loading data for station 1, forceRefresh: true
```

## 常見問題診斷

### 1. 沒有選擇車站
**症狀**：`userHasSelected: false`
**解決**：檢查車站選擇邏輯

### 2. 網絡離線
**症狀**：`Connectivity isOnline: false`
**解決**：檢查網絡連接

### 3. Timer沒有觸發
**症狀**：沒有"Auto-refresh timer triggered"日誌
**解決**：檢查timer設置邏輯

### 4. 數據沒有更新
**症狀**：有timer觸發但數據相同
**解決**：檢查API響應和數據解析

### 5. 自動刷新狀態錯誤
**症狀**：`isAutoRefreshActive`狀態不正確
**解決**：檢查timer狀態管理

## 下一步行動

1. 運行應用並查看調試輸出
2. 根據輸出診斷具體問題
3. 修復發現的問題
4. 重新測試自動刷新功能


