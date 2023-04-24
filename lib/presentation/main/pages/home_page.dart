import 'package:flutter/material.dart';
import 'package:tut/presentation/resources/constants/app_strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStrings.home),
      ),
    );
  }
}
