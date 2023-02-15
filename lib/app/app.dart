import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../presentation/resources/router/app_router.dart';
import '../presentation/resources/styles/app_themes.dart';

class MyApp extends StatefulWidget {
  // single instance with named constractor
  const MyApp._internal();
  static const MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        // The size of ui desing (ex: xd, etc)
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getLight(),
            onGenerateRoute: RouteGenerate.getRoute,
          );
        });
  }
}
