import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';


@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName,String password) = _LoginObject;

}






// draft

// freezed & build_runner
// [1] Function:
//           - These 2 packages works togather to ...
// [2] Installing:
//      - at pubspec.yaml
//         dependencies:
//            freezed : ^4.7.0
//         
//          dev_dependencies:
//            build_runner: ^2.0.0
//
// [3] Generate the file
//      1. import 'package:freezed_annotation/freezed_annotation.dart';
//      2. write "@freezed" above the class you want to generate its file
//      3. mix wite_$[same class name]
//      4. build factory with return _[same class name]
//      5. run at terminal "flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs"