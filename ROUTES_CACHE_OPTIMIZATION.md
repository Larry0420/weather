# Routes 頁面快取優化總結

## 問題描述
在 Routes 頁面中，用戶選擇的地區和路線沒有被正確地快取，導致每次重新進入頁面時都需要重新選擇。

## 解決方案

### 1. 改進 RoutesCatalogProvider 的快取機制

#### 新增功能：
- 添加了 `_hasUserSelectedKey` 來追蹤用戶是否進行過實際選擇
- 新增 `hasUserSelection` getter 來檢查用戶是否已經進行過選擇
- 改進了 `setDistrictIndex` 和 `setRouteIndex` 方法，確保用戶選擇被正確保存

#### 核心改進：
```dart
class RoutesCatalogProvider extends ChangeNotifier {
  static const String _hasUserSelectedKey = 'has_user_selected';
  bool _hasUserSelected = false;
  
  // 檢查用戶是否已經進行過選擇
  bool get hasUserSelection {
    return _hasUserSelected && selectedDistrict != null && selectedRoute != null;
  }
  
  Future<void> setDistrictIndex(int index) async {
    // ... 現有邏輯 ...
    _hasUserSelected = true;
    await _prefs!.setBool(_hasUserSelectedKey, true);
  }
  
  Future<void> setRouteIndex(int index) async {
    // ... 現有邏輯 ...
    _hasUserSelected = true;
    await _prefs!.setBool(_hasUserSelectedKey, true);
  }
}
```

### 2. 優化 _RoutesPage 的狀態管理

#### 改進內容：
- 移除了不必要的本地狀態變數 `_hasUserInteracted`
- 使用 `RoutesCatalogProvider.hasUserSelection` 來判斷用戶選擇狀態
- 在 `initState` 中自動檢查並加載保存的選擇

#### 核心改進：
```dart
@override
void initState() {
  super.initState();
  // 檢查是否有保存的選擇，如果有則自動加載數據
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final cat = context.read<RoutesCatalogProvider>();
    if (cat.hasUserSelection) {
      _loadForRouteIfNeeded();
    }
  });
}
```

### 3. 提升數據加載性能

#### 改進內容：
- 將串行加載改為並行加載，提高多車站數據獲取效率
- 添加錯誤處理和調試日誌
- 優化狀態更新邏輯

#### 核心改進：
```dart
Future<void> _loadForRoute(LrtRoute route, StationProvider sp, ConnectivityProvider net) async {
  // ... 初始化邏輯 ...
  
  // 並行加載所有車站的數據以提高性能
  final futures = ids.map((id) async {
    try {
      final res = await _api.fetch(id);
      return MapEntry(id, res);
    } catch (e) {
      debugPrint('Failed to load data for station $id: $e');
      return null;
    }
  });

  final results = await Future.wait(futures);
  // ... 處理結果 ...
}
```

### 4. 智能選擇恢復

#### 改進內容：
- 當用戶選擇新地區時，自動選擇該地區的第一個路線
- 確保用戶體驗的連續性
- 避免用戶需要手動選擇路線

## 效果

### 用戶體驗改進：
1. **持久化選擇**：用戶選擇的地區和路線會被記住，重新進入頁面時自動恢復
2. **智能恢復**：選擇地區後自動選擇第一個路線，減少用戶操作步驟
3. **性能提升**：並行加載數據，減少等待時間
4. **穩定性增強**：更好的錯誤處理和狀態管理

### 技術改進：
1. **狀態管理優化**：統一使用 Provider 管理狀態，避免本地狀態不一致
2. **快取機制完善**：使用 SharedPreferences 持久化用戶選擇
3. **代碼簡化**：移除冗餘的本地狀態變數，提高代碼可維護性
4. **錯誤處理**：添加適當的錯誤處理和日誌記錄

## 使用方式

用戶現在可以：
1. 在 Routes 頁面選擇地區和路線
2. 切換到其他頁面或關閉應用
3. 重新進入 Routes 頁面時，之前的選擇會自動恢復
4. 系統會自動加載對應的路線數據

這個優化確保了用戶不需要重複選擇相同的地區和路線，大大提升了使用體驗。
