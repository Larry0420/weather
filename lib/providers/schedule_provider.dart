import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lrt_schedule_response.dart';
import '../services/lrt_api_service.dart';

class ScheduleProvider extends ChangeNotifier {
  final LrtApiService _api = LrtApiService();
  LrtScheduleResponse? _data;
  String? _error;
  bool _loading = false;
  bool _isUsingCachedData = false;
  bool _showCacheAlert = true; // 控制快取警告的顯示
  Timer? _timer;
  int? _currentStationId;
  Duration? _currentRefreshInterval;
  int _adjustmentCheckCounter = 0; // 用於控制間隔調整的頻率

  LrtScheduleResponse? get data => _data;
  String? get error => _error;
  bool get loading => _loading;
  bool get isUsingCachedData => _isUsingCachedData;
  bool get showCacheAlert => _showCacheAlert;

  Future<void> load(int stationId, {bool forceRefresh = false}) async {
    debugPrint('Loading data for station $stationId, forceRefresh: $forceRefresh');
    debugPrint('Current station ID before load: $_currentStationId');
    
    // 避免重複加載相同車站，但允許自動刷新
    if (!forceRefresh && _currentStationId == stationId && _data != null) {
      debugPrint('Skipping load - same station and data exists, not forced refresh');
      return;
    }

    _loading = true;
    _error = null;
    _isUsingCachedData = false;
    
    // 只有在沒有自動刷新運行時才設置當前車站ID
    if (_timer == null || !_timer!.isActive) {
      _currentStationId = stationId;
      debugPrint('Setting current station ID to $stationId (no auto-refresh active)');
    } else {
      debugPrint('Keeping current station ID $_currentStationId (auto-refresh active)');
    }
    
    notifyListeners();

    try {
      _data = await _api.fetch(stationId, useCache: !forceRefresh);
      
      // 每5次API調用檢查一次間隔調整，避免過於頻繁的調整
      if (_timer != null && _timer!.isActive) {
        _adjustmentCheckCounter++;
        if (_adjustmentCheckCounter >= 5) {
          _adjustRefreshIntervalIfNeeded();
          _adjustmentCheckCounter = 0;
        }
      }
    } catch (e) {
      _error = e.toString();
      if (_data != null) {
        _isUsingCachedData = true;
        _error = null;
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void _adjustRefreshIntervalIfNeeded() {
    if (_currentStationId == null) return;
    
    final suggestedInterval = LrtApiService.suggestedRefreshInterval;
    final currentInterval = _getCurrentRefreshInterval();
    
    // 如果建議的間隔與當前間隔相差超過20%，則重新調整
    final difference = (currentInterval.inSeconds - suggestedInterval.inSeconds).abs();
    final threshold = currentInterval.inSeconds * 0.2; // 20%閾值
    
    if (difference > threshold) {
      debugPrint('Adjusting refresh interval from ${currentInterval.inSeconds}s to ${suggestedInterval.inSeconds}s');
      _restartAutoRefreshWithNewInterval(suggestedInterval);
    }
  }

  void _restartAutoRefreshWithNewInterval(Duration newInterval) {
    if (_currentStationId == null) return;
    
    final stationId = _currentStationId!;
    _timer?.cancel();
    _timer = Timer.periodic(newInterval, (_) {
      debugPrint('Auto-refresh timer triggered for station $stationId (restarted)');
      load(stationId, forceRefresh: true);
    });
    _currentRefreshInterval = newInterval;
    debugPrint('Auto-refresh restarted with new interval: ${newInterval.inSeconds}s');
  }

  Duration _getCurrentRefreshInterval() {
    return _currentRefreshInterval ?? const Duration(seconds: 5); // 基於API測試結果優化
  }

  void startAutoRefresh(int stationId, {Duration? interval}) {
    debugPrint('=== startAutoRefresh called for station $stationId ===');
    
    // 避免重複啟動相同車站的自動刷新
    if (_currentStationId == stationId && _timer != null && _timer!.isActive) {
      debugPrint('Auto-refresh already active for station $stationId');
      return;
    }

    // 使用自適應間隔或默認間隔
    final refreshInterval = interval ?? LrtApiService.suggestedRefreshInterval;
    debugPrint('Using refresh interval: ${refreshInterval.inSeconds}s');
    
    // 確保清理舊的timer和重置計數器
    _timer?.cancel();
    _adjustmentCheckCounter = 0;
    
    // 先設置當前車站ID，避免在load過程中被改變
    _currentStationId = stationId;
    _currentRefreshInterval = refreshInterval;
    
    _timer = Timer.periodic(refreshInterval, (_) {
      debugPrint('Auto-refresh timer triggered for station $stationId');
      load(stationId, forceRefresh: true); // 強制刷新以獲取最新數據
    });
    
    // 立即加載一次數據
    load(stationId);
    debugPrint('Auto-refresh started for station $stationId with interval: ${refreshInterval.inSeconds}s');
  }

  void stopAutoRefresh() {
    _timer?.cancel();
    _timer = null;
    _currentStationId = null;
    _currentRefreshInterval = null;
    _adjustmentCheckCounter = 0; // 重置調整檢查計數器
    debugPrint('Auto-refresh stopped');
  }

  // 控制快取警告的顯示
  void setShowCacheAlert(bool show) {
    _showCacheAlert = show;
    notifyListeners();
  }

  // 載入快取警告設定
  Future<void> loadCacheAlertSetting() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _showCacheAlert = prefs.getBool('show_cache_alert') ?? true;
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load cache alert setting: $e');
      _showCacheAlert = true; // 預設顯示
    }
  }

  // 儲存快取警告設定
  Future<void> saveCacheAlertSetting() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('show_cache_alert', _showCacheAlert);
    } catch (e) {
      debugPrint('Failed to save cache alert setting: $e');
    }
  }

  @override
  void dispose() {
    stopAutoRefresh();
    super.dispose();
  }
  
  bool get isAutoRefreshActive => _timer != null && _timer!.isActive;
  
  // 獲取當前刷新間隔的描述
  String get currentRefreshIntervalDescription {
    if (!isAutoRefreshActive || _currentRefreshInterval == null) {
      return '';
    }
    return '${_currentRefreshInterval!.inSeconds}s';
  }
  
  // 獲取API響應時間的描述
  String get apiResponseTimeDescription {
    final avgTime = LrtApiService.averageResponseTime;
    return '${avgTime.inMilliseconds}ms';
  }
}