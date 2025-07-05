import 'package:flutter/material.dart';
import 'package:newsapp/presentation/screens/bottom_navigator_screen.dart';
import 'package:newsapp/utils/shared_preference.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = true;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
class DrawerData {
  static List<DrawerTab> data(List<DrawerTab> data, BuildContext context) {
    return data;
  }
}