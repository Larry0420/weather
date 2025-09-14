/// 優化的搜索索引 - 使用 Trie 數據結構
class OptimizedSearchIndex {
  final Map<String, List<int>> _index = {};
  
  void buildIndex(Map<int, Map<String, String>> stations) {
    _index.clear();
    
    for (final entry in stations.entries) {
      final id = entry.key;
      final data = entry.value;
      final en = data['en']!.toLowerCase();
      final zh = data['zh']!;
      
      // 為英文名稱建立前綴索引
      for (int i = 1; i <= en.length; i++) {
        final prefix = en.substring(0, i);
        _index.putIfAbsent(prefix, () => []).add(id);
      }
      
      // 為中文名稱建立前綴索引
      for (int i = 1; i <= zh.length; i++) {
        final prefix = zh.substring(0, i);
        _index.putIfAbsent(prefix, () => []).add(id);
      }
    }
  }
  
  List<int> search(String query) {
    final normalizedQuery = query.toLowerCase();
    final results = _index[normalizedQuery] ?? [];
    
    // 去重並限制結果數量
    return results.toSet().take(20).toList();
  }
}