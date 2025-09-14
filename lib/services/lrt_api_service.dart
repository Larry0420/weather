import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/lrt_schedule_response.dart';

class LrtApiService {
  static const String base = 'https://rt.data.gov.hk/v1/transport/mtr/lrt/getSchedule?station_id=';
  static const Duration ttl = Duration(seconds: 5);
  static final http.Client _client = http.Client();
  static final Map<String, Timer> _debounceTimers = {};
  
  // 響應時間追蹤
  static final List<Duration> _responseTimes = [];
  static const int _maxResponseTimeHistory = 10;
  static Duration _lastResponseTime = Duration.zero;

  static String _key(int stationId) => 'lrt_schedule_$stationId';

  // 獲取平均響應時間
  static Duration get averageResponseTime {
    if (_responseTimes.isEmpty) return const Duration(milliseconds: 59); // 基於實際測試結果
    final total = _responseTimes.fold<Duration>(
      Duration.zero, 
      (sum, time) => sum + time
    );
    return Duration(milliseconds: total.inMilliseconds ~/ _responseTimes.length);
  }

  // 獲取建議的刷新間隔
  static Duration get suggestedRefreshInterval {
    final avgTime = averageResponseTime;
    
    // 基於響應時間計算合適的間隔
    Duration interval;
    if (avgTime.inMilliseconds < 100) {
      // 響應很快（<100ms），使用較短的間隔
      interval = const Duration(seconds: 5);
    } else if (avgTime.inMilliseconds < 500) {
      // 響應中等（100-500ms），使用中等間隔
      interval = const Duration(seconds: 8);
    } else if (avgTime.inMilliseconds < 1000) {
      // 響應較慢（500-1000ms），使用較長間隔
      interval = const Duration(seconds: 12);
    } else {
      // 響應很慢（>1000ms），使用最長間隔
      interval = const Duration(seconds: 15);
    }
    
    // 確保間隔在合理範圍內
    if (interval.inSeconds < 5) interval = const Duration(seconds: 5);
    if (interval.inSeconds > 30) interval = const Duration(seconds: 30);
    
    debugPrint('API response time: ${avgTime.inMilliseconds}ms, suggested interval: ${interval.inSeconds}s');
    return interval;
  }

  Future<LrtScheduleResponse> fetch(int stationId, {bool useCache = true}) async {
    final cacheKey = _key(stationId);
    
    if (useCache) {
      final cached = ApiResponseCache.get(cacheKey);
      if (cached != null) return cached as LrtScheduleResponse;
    }
    
    // 只在實際網絡請求時記錄響應時間
    final startTime = DateTime.now();

    // 防抖處理 - 避免重複請求
    if (_debounceTimers.containsKey(cacheKey)) {
      _debounceTimers[cacheKey]!.cancel();
    }

    final completer = Completer<LrtScheduleResponse>();
    _debounceTimers[cacheKey] = Timer(const Duration(milliseconds: 100), () async {
      try {
        final uri = Uri.parse('$base$stationId');
        final res = await _client.get(uri, headers: {'Accept': 'application/json'})
            .timeout(const Duration(seconds: 10));
            
        if (res.statusCode != 200) {
          throw Exception('HTTP ${res.statusCode}');
        }
        
        final body = json.decode(res.body);
        if (body is! Map<String, dynamic>) throw Exception('Invalid format');
        
        final parsed = LrtScheduleResponse.fromJson(body);
        ApiResponseCache.cache(cacheKey, parsed, ttl: ttl);
        
        // 記錄響應時間
        final endTime = DateTime.now();
        _lastResponseTime = endTime.difference(startTime);
        _responseTimes.add(_lastResponseTime);
        
        // 保持歷史記錄在合理範圍內
        if (_responseTimes.length > _maxResponseTimeHistory) {
          _responseTimes.removeAt(0);
        }
        
        completer.complete(parsed);
      } catch (e) {
        // 嘗試從緩存獲取過期數據
        final cached = ApiResponseCache.get(cacheKey);
        if (cached != null) {
          completer.complete(cached as LrtScheduleResponse);
        } else {
          completer.completeError(e);
        }
      } finally {
        _debounceTimers.remove(cacheKey);
      }
    });

    return completer.future;
  }

  // 測試API響應時間
  static Future<void> testResponseTime() async {
    debugPrint('Testing API response time...');
    const testStationId = 1; // 使用屯門碼頭作為測試
    final api = LrtApiService();
    
    try {
      final startTime = DateTime.now();
      await api.fetch(testStationId, useCache: false);
      final endTime = DateTime.now();
      final responseTime = endTime.difference(startTime);
      
      debugPrint('Test API response time: ${responseTime.inMilliseconds}ms');
      debugPrint('Suggested refresh interval: ${suggestedRefreshInterval.inSeconds}s');
    } catch (e) {
      debugPrint('API test failed: $e');
    }
  }

  static void dispose() {
    _client.close();
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
    ApiResponseCache.clear();
  }
}