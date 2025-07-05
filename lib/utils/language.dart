import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppLanguage with ChangeNotifier {
  Locale _appLocale = const Locale('en');

  Locale get appLocal => _appLocale;
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      // _appLocale = const Locale('hi',"IN");
      // await prefs.setString('language_code', 'hi');
      _appLocale = const Locale('en',"US");
      await prefs.setString('language_code', 'en');

      return _appLocale.languageCode;
    }
    _appLocale = Locale(prefs.getString('language_code')!);
    return _appLocale.languageCode;
  }


  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("hi")) {
      _appLocale = const Locale("hi");
      await prefs.setString('language_code', 'hi');
      await prefs.setString('countryCode', 'IN');
    } else {
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}

