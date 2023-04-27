import 'package:flutter/material.dart';

import '../presentation/resources/languages/app_langauges.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLang = "Prefs-Key-Lang";
const String prefsKeyOnBoarding = "Prefs-Key-onBoarding";
const String prefsKeyLoggedIn = "Prefs-Key-Logged-In";

class AppPrefs {
  final SharedPreferences _sharedPreferences;
  AppPrefs(this._sharedPreferences);


  //* Languages
  String getAppLanguage() {
    String? language = _sharedPreferences.getString(prefsKeyLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return AppLanguages.english.getLanguage();
    }
  }

  void changeAppLanguage() {
    String language = getAppLanguage();
    if (language == AppLanguages.arabic.getLanguage()) {
      _sharedPreferences.setString(
          prefsKeyLang, AppLanguages.english.getLanguage());
    } else {
      _sharedPreferences.setString(
          prefsKeyLang, AppLanguages.arabic.getLanguage());
    }
  }

  Locale getAppLocale() {
    String currentLanguage = getAppLanguage();
    if (currentLanguage == AppLanguages.arabic.getLanguage()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

  //* OnBoarding
  Future<void> setOnBoardingViewed() async {
    _sharedPreferences.setBool(prefsKeyOnBoarding, true);
  }

  bool isOnBoardingViewed() {
    return _sharedPreferences.getBool(prefsKeyOnBoarding) ?? false;
  }

  //* LoggedIn
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(prefsKeyLoggedIn, true);
  }

  bool isUserLoggedIn() {
    return _sharedPreferences.getBool(prefsKeyLoggedIn) ?? false;
  }

  void logout() {
    _sharedPreferences.remove(prefsKeyLoggedIn);
  }
}

// Draft

// you can initialize shared preferences in method init
// class AppPref{
//   static late SharedPreferences _sharedPreferences;
//   static Future<void> init()async{
//     _sharedPreferences = await SharedPreferences.getInstance();

//   }
// }