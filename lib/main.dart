import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tut/presentation/resources/languages/app_langauges.dart';
import 'app/di.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
      supportedLocales: const [arabicLocale, englishLocale],
      path: assetPathLocalizatios,
      child: Phoenix(child: MyApp()),
    ),
  );
}



//  comment for me   "explain functions of framework"
/// comment for other developers  "explain function of program"
/// 

// TODO: draft Phoenix
// ------------------ Phoenix -------------------------
// ----------------------------------------------------
// [1] Easily restart your application from scratch, losing any previous state.
// ----------------------------------------------------


// ==> setup

// code:
// void main() {
//   runApp(
//     Phoenix(
//       child: App(),
//     ),
//   );
// }

// ==> function
//          - make app restart

// code:
// Phoenix.rebirth(context);

