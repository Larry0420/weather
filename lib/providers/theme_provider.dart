import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeColorKey = 'app_theme_color';
  static const String _isDarkModeKey = 'app_is_dark_mode';
  static const String _useSystemThemeKey = 'app_use_system_theme';
  
  Color _seedColor = Colors.green;
  bool _isDarkMode = false;
  bool _useSystemTheme = true;
  SharedPreferences? _prefs;

  Color get seedColor => _seedColor;
  bool get isDarkMode => _isDarkMode;
  bool get useSystemTheme => _useSystemTheme;

  // 預設的主題顏色選項
  static const List<Color> colorOptions = [
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.red,
    Colors.teal,
    Colors.indigo,
    Colors.pink,
    Colors.amber,
    Colors.cyan,
    Colors.deepOrange,
    Colors.deepPurple,
  ];

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    
    // 載入保存的顏色（保存為顏色值）
    final savedColorValue = _prefs!.getInt(_themeColorKey);
    if (savedColorValue != null) {
      _seedColor = Color(savedColorValue);
    }
    
    _isDarkMode = _prefs!.getBool(_isDarkModeKey) ?? false;
    _useSystemTheme = _prefs!.getBool(_useSystemThemeKey) ?? true;
    
    notifyListeners();
  }

  Future<void> setSeedColor(Color color) async {
    _seedColor = color;
    await _save();
  }

  Future<void> setDarkMode(bool darkMode) async {
    _isDarkMode = darkMode;
    await _save();
  }

  Future<void> setUseSystemTheme(bool useSystem) async {
    _useSystemTheme = useSystem;
    await _save();
  }

  Future<void> _save() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setInt(_themeColorKey, _seedColor.toARGB32());
    await _prefs!.setBool(_isDarkModeKey, _isDarkMode);
    await _prefs!.setBool(_useSystemThemeKey, _useSystemTheme);
    notifyListeners();
  }

  String getColorName(Color color, bool isEnglish) {
    if (color == Colors.green) return isEnglish ? 'Green' : '綠色';
    if (color == Colors.blue) return isEnglish ? 'Blue' : '藍色';
    if (color == Colors.purple) return isEnglish ? 'Purple' : '紫色';
    if (color == Colors.orange) return isEnglish ? 'Orange' : '橙色';
    if (color == Colors.red) return isEnglish ? 'Red' : '紅色';
    if (color == Colors.teal) return isEnglish ? 'Teal' : '湖綠色';
    if (color == Colors.indigo) return isEnglish ? 'Indigo' : '靛色';
    if (color == Colors.pink) return isEnglish ? 'Pink' : '粉紅色';
    if (color == Colors.amber) return isEnglish ? 'Amber' : '琥珀色';
    if (color == Colors.cyan) return isEnglish ? 'Cyan' : '青色';
    if (color == Colors.deepOrange) return isEnglish ? 'Deep Orange' : '深橙色';
    if (color == Colors.deepPurple) return isEnglish ? 'Deep Purple' : '深紫色';
    return isEnglish ? 'Custom' : '自定義';
  }
}