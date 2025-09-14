import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _langKey = 'app_language_is_english';
  bool _isEnglish = true;
  SharedPreferences? _prefs;

  bool get isEnglish => _isEnglish;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _isEnglish = _prefs!.getBool(_langKey) ?? true;
    notifyListeners();
  }

  Future<void> setEnglish() async {
    _isEnglish = true;
    await _save();
  }

  Future<void> setChinese() async {
    _isEnglish = false;
    await _save();
  }

  Future<void> toggle() async {
    _isEnglish = !_isEnglish;
    await _save();
  }

  Future<void> _save() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(_langKey, _isEnglish);
    notifyListeners();
  }

  // Labels
  String get appTitle => _isEnglish ? 'LRT Next Train' : '輕鐵班次';
  String get schedule => _isEnglish ? 'Schedule' : '班次表';
  String get routes => _isEnglish ? 'Routes' : '路綫';
  String get settings => _isEnglish ? 'Settings' : '設定';
  String get selectStation => _isEnglish ? 'Select Station' : '選擇車站';
  String get selectDistrict => _isEnglish ? 'Select District' : '選擇地區';
  String get selectRoute => _isEnglish ? 'Select Route' : '選擇路綫';
  String get platform => _isEnglish ? 'Platform' : '月台';
  String get route => _isEnglish ? 'Route' : '路綫';
  String get destination => _isEnglish ? 'Destination' : '目的地';
  String get arrivalTime => _isEnglish ? 'Arrival Time' : '到達時間';
  String get departureTime => _isEnglish ? 'Departure Time' : '開出時間';
  String get trainLength => _isEnglish ? 'Train Length' : '列車長度';
  String get status => _isEnglish ? 'Status' : '狀態';
  String get normal => _isEnglish ? 'Normal' : '正常';
  String get alert => _isEnglish ? 'Alert' : '警示';
  String get system => _isEnglish ? 'System' : '系統';
  String get lastUpdated => _isEnglish ? 'Last updated' : '最後更新';
  String get refresh => _isEnglish ? 'Refresh' : '重新整理';
  String get retry => _isEnglish ? 'Retry' : '重試';
  String get noData => _isEnglish ? 'Please select a route' : '請選擇路綫';
  String get noTrains => _isEnglish ? 'No upcoming trains' : '沒有即將到達的列車';
  String get cars => _isEnglish ? 'cars' : '卡';
  String get arrives => _isEnglish ? 'Arrives' : '到達';
  String get departs => _isEnglish ? 'Departs' : '開出';
  String get serviceStopped => _isEnglish ? 'Service Stopped' : '服務暫停';
  String get normalService => _isEnglish ? 'Normal Service' : '正常服務';
  String get language => _isEnglish ? 'Language' : '語言';
  String get english => 'English';
  String get chinese => '繁體中文';
  String get stationsServed => _isEnglish ? 'Stations Served' : '服務車站';
  String get unmatchedStations => _isEnglish ? 'Unmatched stations' : '未對應車站';
  String get offline => _isEnglish ? 'You are offline' : '您已離綫';
  String get networkError => _isEnglish ? 'Network Error' : '網絡錯誤';
  String get tryAgain => _isEnglish ? 'Try Again' : '重試';
  String get usingCachedData => _isEnglish ? 'Using cached data' : '使用緩存數據';
  String get showCacheAlert => _isEnglish ? 'Show Cache Alert' : '顯示快取警告';
  String get cacheAlertDescription => _isEnglish ? 'Show alert when using cached data' : '使用快取數據時顯示警告';
  String get accessibility => _isEnglish ? 'Accessibility' : '輔助功能';
  String get textSize => _isEnglish ? 'Text Size' : '文字大小';
  String get iconSize => _isEnglish ? 'Icon Size' : '圖示大小';
  String get pageScale => _isEnglish ? 'Page Scale' : '頁面縮放';
  String get screenRotation => _isEnglish ? 'Screen Rotation' : '螢幕旋轉';
  String get enableScreenRotation => _isEnglish ? 'Enable screen rotation' : '啟用螢幕旋轉';
  String get disableScreenRotation => _isEnglish ? 'Disable screen rotation' : '停用螢幕旋轉';
  String get theme => _isEnglish ? 'Theme' : '主題';
  String get themeColor => _isEnglish ? 'Theme Color' : '主題顏色';
  String get darkMode => _isEnglish ? 'Dark Mode' : '深色模式';
  String get lightMode => _isEnglish ? 'Light Mode' : '淺色模式';
  String get systemTheme => _isEnglish ? 'System Theme' : '系統主題';
  String get useSystemTheme => _isEnglish ? 'Use system theme' : '使用系統主題';
  String get manualTheme => _isEnglish ? 'Manual theme selection' : '手動選擇主題';
  String get searchStations => _isEnglish ? 'Search stations...' : '搜尋車站...';
  String get recent => _isEnglish ? 'Recent' : '最近使用';
  String get noStationsFound => _isEnglish ? 'No stations found' : '找不到車站';
  String get selectDistrictDescription => _isEnglish ? 'Choose a district to view available routes' : '選擇一個地區來查看可用的路綫';
  String get selectRouteDescription => _isEnglish ? 'Choose a route to view schedule information' : '選擇一條路綫來查看班次信息';
  String get noScheduleDataDescription => _isEnglish ? 'Choose a route from the list above to view schedules' : '從上方列表中選擇路綫以查看班次';
  String get noTrainsDescription => _isEnglish ? 'No trains available for this route' : '該路綫目前沒有班次信息';
  String get totalTrains => _isEnglish ? 'trains' : '列車';
}