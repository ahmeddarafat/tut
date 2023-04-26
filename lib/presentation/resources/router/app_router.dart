import 'package:flutter/material.dart';
import 'package:tut/presentation/main/main_view.dart';
import '../../../app/di.dart';
import '../../forget_passwrod/view/forget_password_view.dart';
import '../../login/view/login_view.dart';
import '../../onboarding/view/onboarding_view.dart';
import '../../register/view/register_view.dart';
import '../../splash/splash_page.dart';

class AppRoutes {
  static const String splash = "/";
  static const String onBoarding = "/onBoarding";
  static const String main = "/main";
  static const String login = "/login";
  static const String register = "/register";
  static const String forgetPassword = "/forgetPassword";
  static const String storeDetails = "/store details";
}

class RouteGenerate {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingLayouts());
      case AppRoutes.login:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.register:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case AppRoutes.forgetPassword:
        initForgetPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case AppRoutes.main:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      default:
        return MaterialPageRoute(builder: (_) => _undfinedPage(route:routeSettings.name));
    }
  }

  static Scaffold _undfinedPage({String? route}) {
    return Scaffold(
      appBar: AppBar(title: const Text("Undfined Page")),
      body:  Center(child: Text("${route ?? "Undifined"} Page")),
    );
  }
}
