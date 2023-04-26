import 'package:flutter/material.dart';
import 'package:tut/presentation/main/pages/home/view/home_view.dart';
import 'package:tut/presentation/main/pages/notification/view/notifications_view.dart';
import 'package:tut/presentation/main/pages/search/view/search_view.dart';
import 'package:tut/presentation/main/pages/settings/view/settings_view.dart';
import 'package:tut/presentation/resources/styles/app_colors.dart';
import 'package:tut/presentation/resources/widgets/public_text.dart';

import '../resources/constants/app_strings.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String title = AppStrings.home;
  int _currentIndex = 0;

  List<Widget> pages = [
    const HomeView(),
    const SearchView(),
    const NotificationView(),
    const SettingsView(),
  ];
  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notificataions,
    AppStrings.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: PublicText(
          txt: title,
          color: AppColors.white,
          size: 16,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.lightOrange,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: AppColors.orange,
          unselectedItemColor: AppColors.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          // elevation: 10,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_alert), label: 'notifictaion'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
      title = titles[index];
    });
  }
}
