import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../resources/constants/app_assets.dart';
import '../resources/styles/app_colors.dart';
import '../resources/router/app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer _timer;
  final AppPrefs appPrefs = getIt<AppPrefs>();

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  void _goNext() {
    if (appPrefs.isOnBoardingViewed()) {
      if (appPrefs.isUserLoggedIn()) {
        // TODO: return login to home
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.onBoarding);
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Center(child: Image.asset(AppImages.splashLogo)),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
