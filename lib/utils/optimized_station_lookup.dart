import 'dart:collection';

class OptimizedStationLookup {
  static final Map<String, int> _englishToId = {};
  static final Map<String, int> _chineseToId = {};
  static final Map<int, StationData> _idToData = {};
  static bool _initialized = false;

  static void initialize(Map<int, Map<String, String>> stations) {
    if (_initialized) return;
    
    for (final entry in stations.entries) {
      final id = entry.key;
      final data = entry.value;
      final en = data['en']!;
      final zh = data['zh']!;
      
      _englishToId[en.toLowerCase()] = id;
      _chineseToId[zh] = id;
      _idToData[id] = StationData(id: id, nameEn: en, nameZh: zh);
    }
    _initialized = true;
  }

  static int? findById(int id) => _idToData.containsKey(id) ? id : null;
  static int? findByEnglish(String name) => _englishToId[name.toLowerCase()];
  static int? findByChinese(String name) => _chineseToId[name];
  static StationData? getData(int id) => _idToData[id];
  
  static List<StationData> getAllStations() => _idToData.values.toList();
  static int get count => _idToData.length;
}

/// 優化的車站數據結構
class StationData {
  final int id;
  final String nameEn;
  final String nameZh;
  
  const StationData({required this.id, required this.nameEn, required this.nameZh});
  
  String displayName(bool isEnglish) => isEnglish ? nameEn : nameZh;
}