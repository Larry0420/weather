import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/routes_catalog.dart';
import '../data/routes_data.dart';

class RoutesCatalogProvider extends ChangeNotifier {
  static const String _districtKey = 'selected_district_index';
  static const String _routeKey = 'selected_route_index';
  static const String _hasUserSelectedKey = 'has_user_selected';

  LrtRoutesCatalog? _catalog;
  int _districtIndex = 0;
  int _routeIndex = 0;
  bool _hasUserSelected = false;
  SharedPreferences? _prefs;

  LrtRoutesCatalog? get catalog => _catalog;
  int get districtIndex => _districtIndex;
  int get routeIndex => _routeIndex;
  LrtDistrict? get selectedDistrict =>
      (_catalog?.districts.isNotEmpty ?? false) ? _catalog!.districts[_districtIndex] : null;
  LrtRoute? get selectedRoute =>
      (selectedDistrict != null && selectedDistrict!.routes.isNotEmpty)
          ? selectedDistrict!.routes[_routeIndex]
          : null;
          
  // 檢查用戶是否已經進行過選擇
  bool get hasUserSelection {
    final result = _hasUserSelected && selectedDistrict != null && selectedRoute != null;
    debugPrint('RoutesCatalogProvider.hasUserSelection: $_hasUserSelected && ${selectedDistrict != null} && ${selectedRoute != null} = $result');
    return result;
  }

  Future<void> loadFromEmbeddedJson() async {
    try {
      _catalog = _parseRoutesCatalog(kRoutesJson);
      await _restore();
    } catch (_) {
      _catalog = LrtRoutesCatalog(districts: []);
    }
    notifyListeners();
  }

  Future<void> _restore() async {
    _prefs ??= await SharedPreferences.getInstance();
    final d = _prefs!.getInt(_districtKey) ?? 0;
    if (_catalog != null && d < _catalog!.districts.length) _districtIndex = d;
    
    // 確保地區索引有效後再設置路綫索引
    if (_catalog != null && _districtIndex < _catalog!.districts.length) {
      final district = _catalog!.districts[_districtIndex];
      final r = _prefs!.getInt(_routeKey) ?? 0;
      if (r < district.routes.length) _routeIndex = r;
    }
    
    _hasUserSelected = _prefs!.getBool(_hasUserSelectedKey) ?? false;
    
    debugPrint('RoutesCatalogProvider._restore: districtIndex=$_districtIndex, routeIndex=$_routeIndex, hasUserSelected=$_hasUserSelected');
  }

  Future<void> setDistrictIndex(int index) async {
    if (_catalog == null) return;
    if (index < 0 || index >= _catalog!.districts.length) return;
    _districtIndex = index;
    _routeIndex = 0;
    _hasUserSelected = true;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setInt(_districtKey, index);
    await _prefs!.setInt(_routeKey, 0);
    await _prefs!.setBool(_hasUserSelectedKey, true);
    debugPrint('RoutesCatalogProvider.setDistrictIndex: saved districtIndex=$index, routeIndex=0, hasUserSelected=true');
    notifyListeners();
  }

  Future<void> setRouteIndex(int index) async {
    if (selectedDistrict == null) return;
    if (index < 0 || index >= selectedDistrict!.routes.length) return;
    _routeIndex = index;
    _hasUserSelected = true;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setInt(_routeKey, index);
    await _prefs!.setBool(_hasUserSelectedKey, true);
    debugPrint('RoutesCatalogProvider.setRouteIndex: saved routeIndex=$index, hasUserSelected=true');
    notifyListeners();
  }

  static LrtRoutesCatalog _parseRoutesCatalog(String jsonStr) {
    final root = json.decode(jsonStr) as Map<String, dynamic>;
    final sys = root['light_rail_system'] as Map<String, dynamic>;
    final ds = (sys['districts'] as List<dynamic>).map((d) {
      final md = d as Map<String, dynamic>;
      final nameEn = md['name'] as String? ?? '';
      final nameZh = _getDistrictNameZh(nameEn);
      final routes = (md['routes'] as List<dynamic>? ?? []).map((r) {
        final mr = r as Map<String, dynamic>;
        final routeNo = mr['route_number'] as String? ?? '';
        final descEn = mr['description'] as String? ?? '';
        final descZh = _getRouteDescriptionZh(descEn);
        final stations = (mr['stations'] as List<dynamic>? ?? []).map((s) {
          final ms = s as Map<String, dynamic>;
          return LrtRouteStationName(
            en: (ms['name_en'] as String? ?? '').trim(),
            zh: (ms['name_zh'] as String? ?? '').trim(),
          );
        }).toList();
        return LrtRoute(routeNumber: routeNo, descriptionEn: descEn, descriptionZh: descZh, stations: stations);
      }).toList();
      return LrtDistrict(nameEn: nameEn, nameZh: nameZh, routes: routes);
    }).toList();
    return LrtRoutesCatalog(districts: ds);
  }

  static String _getDistrictNameZh(String nameEn) {
    switch (nameEn) {
      case 'Tuen Mun': return '屯門';
      case 'Tin Shui Wai': return '天水圍';
      case 'Inter-District': return '跨區';
      default: return nameEn;
    }
  }

  static String _getRouteDescriptionZh(String descriptionEn) {
    switch (descriptionEn) {
      case 'Sam Shing↔Siu Hong': return '三聖↔兆康';
      case 'Tuen Mun Ferry Pier↔Tin King': return '屯門碼頭↔田景';
      case 'Tuen Mun Ferry Pier↔Siu Hong': return '屯門碼頭↔兆康';
      case 'Tin Shui Wai Loop (Anti-clockwise)': return '天水圍循環綫 (逆時針)';
      case 'Tin Shui Wai Loop (Clockwise)': return '天水圍循環綫 (順時針)';
      case 'Tin Yat↔Tin Shui Wai': return '天逸↔天水圍';
      case 'Tuen Mun Ferry Pier↔Yuen Long': return '屯門碼頭↔元朗';
      case 'Tin Yat↔Yuen Long': return '天逸↔元朗';
      case 'Tin Yat↔Yau Oi': return '天逸↔友愛';
      default: return descriptionEn;
    }
  }
}