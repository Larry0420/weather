import 'dart:collection';

/// 優化的緩存系統 - LRU 緩存策略
class OptimizedCache<K, V> {
  final int maxSize;
  final Map<K, _CacheEntry<V>> _cache = {};
  final Queue<K> _accessOrder = Queue<K>();
  
  OptimizedCache({this.maxSize = 100});
  
  V? get(K key) {
    final entry = _cache[key];
    if (entry == null) return null;
    
    // 更新訪問順序
    _accessOrder.remove(key);
    _accessOrder.add(key);
    entry.lastAccessed = DateTime.now();
    
    return entry.value;
  }
  
  void put(K key, V value) {
    if (_cache.length >= maxSize) {
      // 移除最久未使用的項目
      final oldestKey = _accessOrder.removeFirst();
      _cache.remove(oldestKey);
    }
    
    _cache[key] = _CacheEntry(value);
    _accessOrder.add(key);
  }
  
  void clear() {
    _cache.clear();
    _accessOrder.clear();
  }
  
  int get size => _cache.length;
}

class _CacheEntry<V> {
  final V value;
  DateTime lastAccessed;
  
  _CacheEntry(this.value) : lastAccessed = DateTime.now();
}

/// 優化的 API 響應緩存
class ApiResponseCache {
  static final OptimizedCache<String, _CachedResponse> _cache = OptimizedCache(maxSize: 50);
  static const Duration _defaultTtl = Duration(seconds: 30);
  
  static void cache(String key, dynamic data, {Duration? ttl}) {
    _cache.put(key, _CachedResponse(
      data: data,
      timestamp: DateTime.now(),
      ttl: ttl ?? _defaultTtl,
    ));
  }
  
  static dynamic get(String key) {
    final cached = _cache.get(key);
    if (cached == null) return null;
    
    if (DateTime.now().difference(cached.timestamp) > cached.ttl) {
      // 過期，移除
      _cache._cache.remove(key);
      _cache._accessOrder.remove(key);
      return null;
    }
    
    return cached.data;
  }
  
  static void clear() => _cache.clear();
}

class _CachedResponse {
  final dynamic data;
  final DateTime timestamp;
  final Duration ttl;
  
  _CachedResponse({required this.data, required this.timestamp, required this.ttl});
}