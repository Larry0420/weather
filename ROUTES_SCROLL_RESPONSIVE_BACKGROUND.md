# Routes 頁面滾動響應背景功能

## 功能描述
為路線頁面添加響應式背景效果，當用戶開始滾動時會改變背景外觀，提供更好的視覺反饋和用戶體驗。

## 實現方案

### 1. 滾動監聽器
```dart
class _RoutesPageState extends State<_RoutesPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final isScrolling = offset > 0;
    
    if (_isScrolling != isScrolling || (_scrollOffset - offset).abs() > 10) {
      setState(() {
        _isScrolling = isScrolling;
        _scrollOffset = offset;
      });
    }
  }
}
```

### 2. 響應式背景效果

#### 頂部指示器
```dart
// 響應式頂部背景
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  height: _isScrolling ? 8 : 0,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        Colors.transparent,
      ],
    ),
  ),
),
```

#### 選擇器區域背景
```dart
// 優化的地區和路線選擇器 - 響應式背景
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  decoration: BoxDecoration(
    color: _isScrolling 
      ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.95)
      : Colors.transparent,
    boxShadow: _isScrolling ? [
      BoxShadow(
        color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ] : null,
  ),
  child: Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
    child: Row(
      // 原有的選擇器內容
    ),
  ),
),
```

### 3. 滾動列表集成
```dart
class _RouteSchedulesList extends StatelessWidget {
  final ScrollController scrollController;
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: tiles.length,
      itemBuilder: (context, index) => tiles[index],
    );
  }
}
```

## 視覺效果

### 靜止狀態
- 透明背景
- 無陰影效果
- 頂部無指示器

### 滾動狀態
- 半透明背景覆蓋
- 柔和陰影效果
- 頂部漸變指示器
- 平滑動畫過渡

## 技術特點

### 性能優化
- 使用 `AnimatedContainer` 實現平滑過渡
- 滾動閾值檢測避免過度更新
- 適當的動畫持續時間

### 用戶體驗
- 300ms 的平滑過渡動畫
- 視覺層次清晰
- 不干擾內容閱讀

### 可訪問性
- 支持主題色彩
- 適應不同屏幕尺寸
- 保持內容可讀性

## 實現步驟

1. **添加滾動控制器**：在 `_RoutesPageState` 中初始化
2. **實現滾動監聽**：添加 `_onScroll` 方法
3. **更新UI結構**：添加響應式背景容器
4. **集成到列表**：將控制器傳遞給 `_RouteSchedulesList`
5. **測試和調優**：確保動畫流暢且不影響性能

這個功能將為路線頁面提供更好的視覺反饋，讓用戶清楚地知道頁面正在滾動，同時保持界面的現代感和專業性。
