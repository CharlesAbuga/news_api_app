import 'package:flutter/material.dart';
import 'package:news_app_ui/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChange extends ChangeNotifier {
  ThemeData _themeData;

  ThemeChange(this._themeData);

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeData theme) async {
    _themeData = theme;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLightTheme', theme == lightTheme);
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLightTheme = prefs.getBool('isLightTheme') ?? true;
    _themeData = isLightTheme ? lightTheme : darkTheme;
    notifyListeners();
  }
}
