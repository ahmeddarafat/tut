import 'package:flutter/material.dart';
import 'package:tut/presentation/resources/constants/app_strings.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStrings.search),
      ),
    );
  }
}
