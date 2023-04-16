// ==> Usage
//      - To reduce written code size

/// before

import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed.freezed.dart';

class Person {
  final String name;
  final int age;

  Person({
    required this.name,
    required this.age,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json["name"] as String,
      age: json["age"] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
    };
  }

  @override
  String toString() {
    return """ Person
    name': $name,
    'age' : $age,
    ) """;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, name, age);
  }

  @override
  bool operator ==(Object other) {
    return other is Person && name == other.name && age == other.age;
  }
}

/// after

// write "@freezed" above the class you want to generate its file
@freezed
class Person2 with _$Person2 {
  factory Person2(String name, String age) = _Person2;
}

// Then run At terminal
//     - flutter pub run build_runner build --delete-conflicting-outputs
//       -- to generate the file
