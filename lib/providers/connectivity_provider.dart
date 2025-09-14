import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool _isOnline = true;
  StreamSubscription<List<ConnectivityResult>>? _sub;

  bool get isOnline => _isOnline;
  bool get isOffline => !_isOnline;

  ConnectivityProvider() {
    _init();
    _sub = Connectivity().onConnectivityChanged.listen(_update);
  }

  Future<void> _init() async {
    try {
      final res = await Connectivity().checkConnectivity();
      _update(res);
    } catch (_) {
      _isOnline = false;
      notifyListeners();
    }
  }

  void _update(List<ConnectivityResult> results) {
    final wasOnline = _isOnline;
    _isOnline = !results.contains(ConnectivityResult.none);
    if (wasOnline != _isOnline) notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}