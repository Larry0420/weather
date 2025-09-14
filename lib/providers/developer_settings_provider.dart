import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeveloperSettingsProvider extends ChangeNotifier {
  static const String _hideStationIdKey = 'hide_station_id';
  
  bool _hideStationId = false;
  SharedPreferences? _prefs;

  bool get hideStationId => _hideStationId;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _hideStationId = _prefs!.getBool(_hideStationIdKey) ?? false;
    notifyListeners();
  }

  Future<void> setHideStationId(bool hide) async {
    _hideStationId = hide;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool(_hideStationIdKey, hide);
    notifyListeners();
  }
}