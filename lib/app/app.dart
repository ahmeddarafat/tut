import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tut/app/app_prefs.dart';

import '../presentation/resources/router/app_router.dart';
import '../presentation/resources/styles/app_themes.dart';
import 'di.dart';

class MyApp extends StatefulWidget {
  // single instance with named constractor
  const MyApp._internal();
  static const MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPrefs _appPrefs = getIt<AppPrefs>();

  // TODO: didChangeDependencies,
  // todo: I don't know what this block means
  @override
  void didChangeDependencies() {
    Locale locale =_appPrefs.getAppLocale();
    context.setLocale(locale);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        // The size of ui desing (ex: xd, etc)
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getLight(),
            onGenerateRoute: RouteGenerate.getRoute,
          );
        });
  }
}
// TODO: logical error
// todo: the strings aren't changing until restart the app  


// TODO: Draft easy localization
// ------------------ localization -----------------------
// -------------------------------------------------------
// [1] Installation 
// -------------------------------------------------------


// ==> Installing
//         - add its dependency
//         - create folder "translations "inside assets which include json files for
//           each language
//         - add its assets folder

// dependencies:
//   easy_localization: <last_version>

// assets
// └── translations
//     ├── en.json
//     └── en-US.json

// flutter:
//   assets:
//     - assets/translations/


// ==> Setup

// void main() async {
//   **WidgetsFlutterBinding.ensureInitialized();
//   **await EasyLocalization.ensureInitialized();
//   runApp(
//     **EasyLocalization(
//       **supportedLocales: [Locale('en', 'US'), Locale('de', 'DE')],
//       **path: 'assets/translations', // <-- change the path of the translation files 
//       **fallbackLocale: Locale('en', 'US'),
//       child: MyApp()
//     ),
//   );
// }
// ----------------------------------------
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       **localizationsDelegates: context.localizationDelegates,
//       **supportedLocales: context.supportedLocales,
//       **locale: context.locale,
//       home: MyHomePage()
//     );
//   }
// }


// ==> Usage
//       -  Change or get locale
//       -  Translate 

// context.setLocale(Locale('en', 'US'));
// --------------------------
// Text('title').tr() //Text widget
// print('title'.tr()); //String
