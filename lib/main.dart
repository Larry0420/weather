import 'dart:async';
import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';
import 'package:implicitly_animated_reorderable_list_2/transitions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Import extracted modules
import 'providers/connectivity_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/developer_settings_provider.dart';
import 'providers/accessibility_provider.dart';
import 'providers/language_provider.dart';
import 'providers/routes_catalog_provider.dart';
import 'providers/station_provider.dart';
import 'providers/schedule_provider.dart';
import 'services/lrt_api_service.dart';
import 'utils/optimized_station_lookup.dart';
import 'utils/optimized_cache.dart';
import 'utils/optimized_search_index.dart';
import 'utils/app_colors.dart';
import 'utils/motion_constants.dart';
import 'utils/ui_constants.dart';

// ========================= Station Grouping (Top-level) =========================
class _StationGroupInfo {
  const _StationGroupInfo(this.name, this.nameEn, this.stationIds);
  final String name;
  final String nameEn;
  final Set<int> stationIds;
}

// Single source of truth for all station groupings, based on the Light Rail map.
const _stationGroups = [
  // Tin Shui Wai (Zone 4 & 5A)
  _StationGroupInfo('天水圍北', 'Tin Shui Wai North', {490, 500, 510, 520, 530, 540, 550}),
  _StationGroupInfo('天水圍南', 'Tin Shui Wai South', {430, 435, 445, 448, 450, 455, 460, 468, 480}),

  // Yuen Long (Zone 4 & 5)
  _StationGroupInfo('元朗市中心', 'Yuen Long Central', {560, 570, 580, 590, 600}),
  _StationGroupInfo('屏山段', 'Ping Shan Section', {400, 425}),
  _StationGroupInfo('洪水橋段', 'Hung Shui Kiu Section', {370, 380, 390}),

  // Tuen Mun (Zone 1, 2, & 3)
  _StationGroupInfo('屯門碼頭區', 'Tuen Mun Ferry Pier', {1, 10, 15, 20, 30, 40, 50, 920}),
  _StationGroupInfo('屯門市中心', 'Tuen Mun Central', {60, 70, 75, 80, 90, 212, 220, 230, 240, 250, 260, 265, 270, 275, 280, 295, 300, 310, 320, 330, 340, 350, 360}),
  _StationGroupInfo('屯門北區', 'Tuen Mun North', {100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200}),
];

// A lookup map for efficient retrieval of group info by station ID.
final Map<int, _StationGroupInfo> _stationGroupCache = {
  for (var group in _stationGroups)
    for (var id in group.stationIds) id: group
};

/// Returns the Chinese name of the station group for a given [stationId].
String _getStationGroup(int stationId) {
  return _stationGroupCache[stationId]?.name ?? '其他';
}

/// Returns the English name of the station group for a given [stationId].
String _getStationGroupEn(int stationId) {
  return _stationGroupCache[stationId]?.nameEn ?? 'Others';
}

// ========================= 通用組件 =========================

/// 自適應圓圈文字組件 - 自動縮放文字以適應圓圈大小
class AdaptiveCircleText extends StatelessWidget {
  final String text;
  final double circleSize;
  final double baseFontSize;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;

  const AdaptiveCircleText({
    super.key,
    required this.text,
    required this.circleSize,
    required this.baseFontSize,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Center(
        child: AutoSizeText(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: baseFontSize,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          minFontSize: 8,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始設定螢幕方向為直向，稍後會由 AccessibilityProvider 控制
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  
  // 設定系統UI樣式
  if (!kIsWeb) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
  
  // 測試API響應時間以優化自動刷新間隔
  await LrtApiService.testResponseTime();
  
  runApp(const LrtApp());
}

class LrtApp extends StatelessWidget {
  const LrtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => AccessibilityProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => DeveloperSettingsProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => StationProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()..loadCacheAlertSetting()),
        ChangeNotifierProvider(create: (_) => RoutesCatalogProvider()..loadFromEmbeddedJson()),
      ],
      child: Builder(
        builder: (context) {
          return Consumer3<LanguageProvider, ThemeProvider, AccessibilityProvider>(
            builder: (context, lang, themeProvider, accessibility, _) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(accessibility.pageScale),
                ),
                child: MaterialApp(
                  title: lang.isEnglish ? 'LRT Next Train' : '輕鐵班次',
                  theme: ThemeData(
                    useMaterial3: true,
                    colorSchemeSeed: themeProvider.seedColor,
                    brightness: themeProvider.useSystemTheme
                        ? MediaQuery.of(context).platformBrightness
                        : (themeProvider.isDarkMode ? Brightness.dark : Brightness.light),
                  ),
                  home: const HomePage(),
                  debugShowCheckedModeBanner: false,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ========================= UI Shell =========================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final scheduleProvider = context.read<ScheduleProvider>();
    
    switch (state) {
      case AppLifecycleState.resumed:
        // 應用程式恢復時重新啟動自動刷新
        final stationProvider = context.read<StationProvider>();
        if (stationProvider.userHasSelected) {
          scheduleProvider.startAutoRefresh(stationProvider.selectedStationId);
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        // 應用程式暫停或關閉時停止自動刷新
        scheduleProvider.stopAutoRefresh();
        break;
      default:
        break;
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: MotionConstants.pageTransition,
      curve: MotionConstants.standardEasing,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          _SchedulePage(),
          _RoutesPage(),
          _SettingsPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onTabTapped,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.schedule),
            label: lang.schedule,
          ),
          NavigationDestination(
            icon: const Icon(Icons.route),
            label: lang.routes,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings),
            label: lang.settings,
          ),
        ],
      ),
    );
  }
}

// ========================= Schedule Page =========================

class _SchedulePage extends StatelessWidget {
  const _SchedulePage();

  @override
  Widget build(BuildContext context) {
    return const _ScheduleBody();
  }
}

class _ScheduleBody extends StatelessWidget {
  const _ScheduleBody();

  @override
  Widget build(BuildContext context) {
    final connectivity = context.watch<ConnectivityProvider>();
    final schedule = context.watch<ScheduleProvider>();
    final station = context.watch<StationProvider>();
    final lang = context.watch<LanguageProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.schedule),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (station.userHasSelected) {
                schedule.load(station.selectedStationId, forceRefresh: true);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (connectivity.isOffline) const _OfflineBanner(),
          if (schedule.isUsingCachedData && schedule.showCacheAlert) const _CachedDataBanner(),
          Expanded(
            child: station.userHasSelected
                ? _buildScheduleContent(context, schedule, station, lang)
                : _buildStationSelector(context, station, schedule, lang),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleContent(BuildContext context, ScheduleProvider schedule, StationProvider station, LanguageProvider lang) {
    if (schedule.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (schedule.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(schedule.error!, style: UIConstants.scheduleErrorStyle(context, context.watch<AccessibilityProvider>())),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => schedule.load(station.selectedStationId, forceRefresh: true),
              child: Text(lang.retry),
            ),
          ],
        ),
      );
    }

    if (schedule.data == null) {
      return Center(
        child: Text(
          lang.noData,
          style: UIConstants.scheduleNoDataStyle(context, context.watch<AccessibilityProvider>()),
        ),
      );
    }

    return _buildScheduleList(context, schedule, station, lang);
  }

  Widget _buildScheduleList(BuildContext context, ScheduleProvider schedule, StationProvider station, LanguageProvider lang) {
    final data = schedule.data!;
    final platforms = data.platforms;

    if (platforms.isEmpty) {
      return Center(
        child: Text(
          lang.noTrains,
          style: UIConstants.scheduleNoDataStyle(context, context.watch<AccessibilityProvider>()),
        ),
      );
    }

    return ListView.builder(
      padding: UIConstants.scheduleCardMargin,
      itemCount: platforms.length,
      itemBuilder: (context, index) {
        final platform = platforms[index];
        return _PlatformCard(platform: platform);
      },
    );
  }

  Widget _buildStationSelector(BuildContext context, StationProvider station, ScheduleProvider schedule, LanguageProvider lang) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.train, size: 64, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            lang.selectStation,
            style: UIConstants.scheduleNoDataStyle(context, context.watch<AccessibilityProvider>()),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _showStationSelector(context, station, schedule),
            child: Text(lang.selectStation),
          ),
        ],
      ),
    );
  }

  void _showStationSelector(BuildContext context, StationProvider station, ScheduleProvider schedule) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => _OptimizedStationSelector(
          stationProvider: station,
          scheduleProvider: schedule,
          isEnglish: context.watch<LanguageProvider>().isEnglish,
        ),
      ),
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner();

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.errorContainer,
      child: Row(
        children: [
          Icon(Icons.wifi_off, color: Theme.of(context).colorScheme.onErrorContainer),
          const SizedBox(width: 8),
          Text(
            lang.offline,
            style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
          ),
        ],
      ),
    );
  }
}

class _CachedDataBanner extends StatelessWidget {
  const _CachedDataBanner();

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Row(
        children: [
          Icon(Icons.cached, color: Theme.of(context).colorScheme.onSecondaryContainer),
          const SizedBox(width: 8),
          Text(
            lang.usingCachedData,
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ],
      ),
    );
  }
}

class _PlatformCard extends StatelessWidget {
  final PlatformSchedule platform;

  const _PlatformCard({required this.platform});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final accessibility = context.watch<AccessibilityProvider>();
    
    return Card(
      margin: UIConstants.scheduleCardMargin,
      child: Padding(
        padding: UIConstants.scheduleCardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${lang.platform} ${platform.platform}',
              style: UIConstants.scheduleTitleStyle(context, accessibility),
            ),
            const SizedBox(height: 8),
            if (platform.trains.isEmpty)
              Text(
                lang.noTrains,
                style: UIConstants.scheduleBodyStyle(context, accessibility),
              )
            else
              ...platform.trains.map((train) => _TrainTile(train: train)),
          ],
        ),
      ),
    );
  }
}

class _TrainTile extends StatelessWidget {
  final TrainInfo train;

  const _TrainTile({required this.train});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final accessibility = context.watch<AccessibilityProvider>();
    
    return ListTile(
      contentPadding: UIConstants.scheduleListTilePadding,
      leading: UIConstants.scheduleCircleText(
        text: train.route,
        accessibility: accessibility,
        isStopped: train.isStopped,
        context: context,
      ),
      title: Text(
        train.destination(lang.isEnglish),
        style: UIConstants.scheduleTrainNameStyle(context, accessibility),
      ),
      subtitle: Text(
        train.time(lang.isEnglish),
        style: UIConstants.scheduleBodyStyle(context, accessibility),
      ),
      trailing: train.isStopped
          ? Icon(Icons.error, color: Theme.of(context).colorScheme.error)
          : null,
    );
  }
}

// ========================= Routes Page =========================

class _RoutesPage extends StatefulWidget {
  const _RoutesPage();

  @override
  State<_RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<_RoutesPage> {
  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.routes),
      ),
      body: const Center(
        child: Text('Routes page - to be implemented'),
      ),
    );
  }
}

// ========================= Settings Page =========================

class _SettingsPage extends StatelessWidget {
  const _SettingsPage();

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.settings),
      ),
      body: const Center(
        child: Text('Settings page - to be implemented'),
      ),
    );
  }
}

// ========================= Station Selector =========================

class _OptimizedStationSelector extends StatefulWidget {
  final StationProvider stationProvider;
  final ScheduleProvider scheduleProvider;
  final bool isEnglish;

  const _OptimizedStationSelector({
    required this.stationProvider,
    required this.scheduleProvider,
    required this.isEnglish,
  });

  @override
  State<_OptimizedStationSelector> createState() => _OptimizedStationSelectorState();
}

class _OptimizedStationSelectorState extends State<_OptimizedStationSelector>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController _searchController = TextEditingController();
  List<StationData> _filteredStations = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: MotionConstants.contentTransition,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: MotionConstants.standardEasing,
    );
    _animationController.forward();
    _filteredStations = widget.stationProvider.searchStations('');
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredStations = widget.stationProvider.searchStations(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final accessibility = context.watch<AccessibilityProvider>();
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              lang.selectStation,
              style: UIConstants.scheduleTitleStyle(context, accessibility),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: lang.searchStations,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredStations.length,
              itemBuilder: (context, index) {
                final station = _filteredStations[index];
                return ListTile(
                  title: Text(station.displayName(widget.isEnglish)),
                  subtitle: Text('ID: ${station.id}'),
                  onTap: () {
                    widget.stationProvider.setStation(station.id);
                    widget.scheduleProvider.startAutoRefresh(station.id);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}