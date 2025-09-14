import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessibilityProvider extends ChangeNotifier {
  static const String _textScaleKey = 'app_text_scale';
  static const String _iconScaleKey = 'app_icon_scale';
  static const String _screenRotationKey = 'app_screen_rotation_enabled';
  static const String _pageScaleKey = 'app_page_scale';
  
  double _textScale = 1.0;
  double _iconScale = 1.0;
  bool _screenRotationEnabled = true;
  double _pageScale = 1.0;
  SharedPreferences? _prefs;

  double get textScale => _textScale;
  double get iconScale => _iconScale;
  bool get screenRotationEnabled => _screenRotationEnabled;
  double get pageScale => _pageScale;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _textScale = _prefs!.getDouble(_textScaleKey) ?? 1.0;
    _iconScale = _prefs!.getDouble(_iconScaleKey) ?? 1.0;
    _screenRotationEnabled = _prefs!.getBool(_screenRotationKey) ?? true;
    _pageScale = _prefs!.getDouble(_pageScaleKey) ?? 1.0;
    notifyListeners();
    _applyScreenRotationSetting();
  }

  Future<void> setTextScale(double scale) async {
    _textScale = scale.clamp(0.8, 2.0); // 限制範圍在 0.8 到 2.0 之間
    await _save();
  }

  Future<void> setIconScale(double scale) async {
    _iconScale = scale.clamp(0.8, 2.0); // 限制範圍在 0.8 到 2.0 之間
    await _save();
  }

  Future<void> setScreenRotationEnabled(bool enabled) async {
    _screenRotationEnabled = enabled;
    await _save();
    _applyScreenRotationSetting();
  }

  Future<void> setPageScale(double scale) async {
    _pageScale = scale.clamp(0.8, 2.0); // 限制範圍在 0.8 到 2.0 之間
    await _save();
  }

  Future<void> _save() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setDouble(_textScaleKey, _textScale);
    await _prefs!.setDouble(_iconScaleKey, _iconScale);
    await _prefs!.setBool(_screenRotationKey, _screenRotationEnabled);
    await _prefs!.setDouble(_pageScaleKey, _pageScale);
    notifyListeners();
  }

  void _applyScreenRotationSetting() {
    if (kIsWeb) return; // Web 平台不支援螢幕方向控制
    
    if (_screenRotationEnabled) {
      // 允許所有方向
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      // 只允許直向
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  // 預設文字、圖示和頁面縮放選項
  static const List<double> textScaleOptions = [0.8, 0.9, 1.0, 1.2, 1.5, 2.0];
  static const List<double> iconScaleOptions = [0.8, 0.9, 1.0, 1.2, 1.5, 2.0];
  static const List<double> pageScaleOptions = [0.8, 0.9, 1.0, 1.2, 1.5, 2.0];
  
  String getTextSizeLabel(double scale, bool isEnglish) {
    if (scale == 0.8) return isEnglish ? 'Very Small' : '非常小';
    if (scale == 0.9) return isEnglish ? 'Small' : '小';
    if (scale == 1.0) return isEnglish ? 'Normal' : '正常';
    if (scale == 1.2) return isEnglish ? 'Large' : '大';
    if (scale == 1.5) return isEnglish ? 'Very Large' : '非常大';
    if (scale == 2.0) return isEnglish ? 'Extra Large' : '超大';
    return isEnglish ? 'Custom' : '自定義';
  }
  
  String getIconSizeLabel(double scale, bool isEnglish) {
    if (scale == 0.8) return isEnglish ? 'Very Small' : '非常小';
    if (scale == 0.9) return isEnglish ? 'Small' : '小';
    if (scale == 1.0) return isEnglish ? 'Normal' : '正常';
    if (scale == 1.2) return isEnglish ? 'Large' : '大';
    if (scale == 1.5) return isEnglish ? 'Very Large' : '非常大';
    if (scale == 2.0) return isEnglish ? 'Extra Large' : '超大';
    return isEnglish ? 'Custom' : '自定義';
  }
  
  String getPageScaleLabel(double scale, bool isEnglish) {
    if (scale == 0.8) return isEnglish ? 'Very Small' : '非常小';
    if (scale == 0.9) return isEnglish ? 'Small' : '小';
    if (scale == 1.0) return isEnglish ? 'Normal' : '正常';
    if (scale == 1.2) return isEnglish ? 'Large' : '大';
    if (scale == 1.5) return isEnglish ? 'Very Large' : '非常大';
    if (scale == 2.0) return isEnglish ? 'Extra Large' : '超大';
    return isEnglish ? 'Custom' : '自定義';
  }
}