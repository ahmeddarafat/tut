import '../presentation/resources/languages/app_langauges.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLang = "Prefs-Key-Lang";

class AppPrefs{
  final SharedPreferences _sharedPreferences;
  AppPrefs(this._sharedPreferences);

  String getAppLanguage(){
    String? language = _sharedPreferences.getString(prefsKeyLang);
    if(language !=null && language.isNotEmpty){
      return language;
    }else{
      return AppLanguages.english.getLanguage();
    }
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