import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkTheme = false;
  static const String ThemeKey = 'ThemeKey';
  bool get isDarkTheme => _darkTheme;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      _darkTheme = await getDarkTheme();
      _initialized = true;
      notifyListeners();
    }
  }

  Future<void> setDarkTheme({required bool valueTheme}) async {
    if (_darkTheme != valueTheme) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setBool(ThemeKey, valueTheme);
      _darkTheme = valueTheme;
      notifyListeners();
    }
  }

  Future<bool> getDarkTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _darkTheme = (pref.getBool(ThemeKey)) ?? false;
    notifyListeners();
    return _darkTheme;
  }
}
