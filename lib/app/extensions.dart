
// Extension:
// it add some methods for a certain class [String]
import 'package:tut/app/constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}
extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}

// when you use
// void test(){
//   int? number ;
//   int? number2 =5;

//   print(number.orZero());  //  0
//   print(number2.orZero());  //  5
// }
