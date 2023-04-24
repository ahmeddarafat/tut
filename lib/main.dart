import 'package:flutter/material.dart';
import 'app/di.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}



//  comment for me   "explain functions of framework"
/// comment for other developers  "explain function of program"