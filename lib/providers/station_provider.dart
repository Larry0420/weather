import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/optimized_station_lookup.dart';
import '../utils/optimized_search_index.dart';

class StationProvider extends ChangeNotifier {
  static const String _stationKey = 'selected_station_id';

  final Map<int, Map<String, String>> stations = const {
    1: {'en': 'Tuen Mun Ferry Pier', 'zh': '屯門碼頭'},
    10: {'en': 'Melody Garden', 'zh': '美樂'},
    15: {'en': 'Butterfly', 'zh': '蝴蝶'},
    20: {'en': 'Light Rail Depot', 'zh': '輕鐵車廠'},
    30: {'en': 'Lung Mun', 'zh': '龍門'},
    40: {'en': 'Tsing Shan Tsuen', 'zh': '青山村'},
    50: {'en': 'Tsing Wun', 'zh': '青雲'},
    60: {'en': 'Kin On', 'zh': '建安'},
    70: {'en': 'Ho Tin', 'zh': '河田'},
    75: {'en': 'Choy Yee Bridge', 'zh': '蔡意橋'},
    80: {'en': 'Affluence', 'zh': '澤豐'},
    90: {'en': 'Tuen Mun Hospital', 'zh': '屯門醫院'},
    100: {'en': 'Siu Hong', 'zh': '兆康'},
    110: {'en': 'Kei Lun', 'zh': '麒麟'},
    120: {'en': 'Ching Chung', 'zh': '青松'},
    130: {'en': 'Kin Sang', 'zh': '建生'},
    140: {'en': 'Tin King', 'zh': '田景'},
    150: {'en': 'Leung King', 'zh': '良景'},
    160: {'en': 'San Wai', 'zh': '新圍'},
    170: {'en': 'Shek Pai', 'zh': '石排'},
    180: {'en': 'Shan King (North)', 'zh': '山景 (北)'},
    190: {'en': 'Shan King (South)', 'zh': '山景 (南)'},
    200: {'en': 'Ming Kum', 'zh': '鳴琴'},
    212: {'en': 'Tai Hing (North)', 'zh': '大興 (北)'},
    220: {'en': 'Tai Hing (South)', 'zh': '大興 (南)'},
    230: {'en': 'Ngan Wai', 'zh': '銀圍'},
    240: {'en': 'Siu Hei', 'zh': '兆禧'},
    250: {'en': 'Tuen Mun Swimming Pool', 'zh': '屯門泳池'},
    260: {'en': 'Goodview Garden', 'zh': '豐景園'},
    265: {'en': 'Siu Lun', 'zh': '兆麟'},
    270: {'en': 'On Ting', 'zh': '安定'},
    275: {'en': 'Yau Oi', 'zh': '友愛'},
    280: {'en': 'Town Centre', 'zh': '市中心'},
    295: {'en': 'Tuen Mun', 'zh': '屯門'},
    300: {'en': 'Pui To', 'zh': '杯渡'},
    310: {'en': 'Hoh Fuk Tong', 'zh': '何福堂'},
    320: {'en': 'San Hui', 'zh': '新墟'},
    330: {'en': 'Prime View', 'zh': '景峰'},
    340: {'en': 'Fung Tei', 'zh': '鳳地'},
    350: {'en': 'Lam Tei', 'zh': '藍地'},
    360: {'en': 'Nai Wai', 'zh': '泥圍'},
    370: {'en': 'Chung Uk Tsuen', 'zh': '鍾屋村'},
    380: {'en': 'Hung Shui Kiu', 'zh': '洪水橋'},
    390: {'en': 'Tong Fong Tsuen', 'zh': '塘坊村'},
    400: {'en': 'Ping Shan', 'zh': '屏山'},
    425: {'en': 'Hang Mei Tsuen', 'zh': '坑尾村'},
    430: {'en': 'Tin Shui Wai', 'zh': '天水圍'},
    435: {'en': 'Tin Tsz', 'zh': '天慈'},
    445: {'en': 'Tin Yiu', 'zh': '天耀'},
    448: {'en': 'Locwood', 'zh': '樂湖'},
    450: {'en': 'Tin Wu', 'zh': '天湖'},
    455: {'en': 'Ginza', 'zh': '銀座'},
    460: {'en': 'Tin Shui', 'zh': '天瑞'},
    468: {'en': 'Chung Fu', 'zh': '頌富'},
    480: {'en': 'Tin Fu', 'zh': '天富'},
    490: {'en': 'Chestwood', 'zh': '翠湖'},
    500: {'en': 'Tin Wing', 'zh': '天榮'},
    510: {'en': 'Tin Yuet', 'zh': '天悅'},
    520: {'en': 'Tin Sau', 'zh': '天秀'},
    530: {'en': 'Wetland Park', 'zh': '濕地公園'},
    540: {'en': 'Tin Heng', 'zh': '天恒'},
    550: {'en': 'Tin Yat', 'zh': '天逸'},
    560: {'en': 'Shui Pin Wai', 'zh': '水邊圍'},
    570: {'en': 'Fung Nin Road', 'zh': '豐年路'},
    580: {'en': 'Hong Lok Road', 'zh': '康樂路'},
    590: {'en': 'Tai Tong Road', 'zh': '大棠路'},
    600: {'en': 'Yuen Long', 'zh': '元朗'},
    920: {'en': 'Sam Shing', 'zh': '三聖'},
  };

  int _selectedStationId = 600;
  bool _userHasSelected = false;
  SharedPreferences? _prefs;
  late final OptimizedSearchIndex _searchIndex;

  int get selectedStationId => _selectedStationId;
  bool get userHasSelected => _userHasSelected;

  StationProvider() {
    // 初始化優化的查找表和搜索索引
    OptimizedStationLookup.initialize(stations);
    _searchIndex = OptimizedSearchIndex();
    _searchIndex.buildIndex(stations);
  }

  Future<void> initialize() async {
    debugPrint('=== StationProvider initialize called ===');
    _prefs = await SharedPreferences.getInstance();
    final saved = _prefs!.getInt(_stationKey);
    debugPrint('Saved station ID: $saved');
    
    if (saved != null && stations.containsKey(saved)) {
      _selectedStationId = saved;
      _userHasSelected = true;
      debugPrint('Restored station ID: $_selectedStationId, userHasSelected: $_userHasSelected');
    } else {
      debugPrint('No saved station or invalid station ID');
    }
    notifyListeners();
  }

  Future<void> setStation(int stationId) async {
    debugPrint('=== setStation called for station $stationId ===');
    if (!stations.containsKey(stationId)) {
      debugPrint('Invalid station ID: $stationId');
      return;
    }
    _selectedStationId = stationId;
    _userHasSelected = true;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setInt(_stationKey, stationId);
    debugPrint('Station set to: $_selectedStationId, userHasSelected: $_userHasSelected');
    notifyListeners();
  }

  // O(1) 時間複雜度的查找方法
  int? idByEnglish(String name) => OptimizedStationLookup.findByEnglish(name);
  int? idByChinese(String name) => OptimizedStationLookup.findByChinese(name);
  int? idByEither(String en, String zh) => OptimizedStationLookup.findByEnglish(en) ?? OptimizedStationLookup.findByChinese(zh);

  String displayName(int id, bool isEnglish) {
    final data = OptimizedStationLookup.getData(id);
    if (data == null) return 'Unknown';
    return data.displayName(isEnglish);
  }

  // 優化的搜索方法 - O(k) 其中 k 是搜索結果數量
  List<StationData> searchStations(String query) {
    if (query.isEmpty) return OptimizedStationLookup.getAllStations();
    
    final resultIds = _searchIndex.search(query);
    return resultIds
        .map((id) => OptimizedStationLookup.getData(id))
        .where((data) => data != null)
        .cast<StationData>()
        .toList();
  }
}