import 'package:flutter/material.dart';
import 'package:tut/presentation/resources/constants/app_strings.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStrings.notificataions),
      ),
    );
  }
}
