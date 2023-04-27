import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut/presentation/resources/constants/app_strings.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: const Text(AppStrings.search).tr(),
      ),
    );
  }
}
