const String arabic = "ar";
const String english = "en";

enum AppLanguages { arabic, english }

extension AppLanguagesExtension on AppLanguages {
  String getLanguage() {
    switch (this) {
      case AppLanguages.arabic:
        return arabic;
      case AppLanguages.english:
        return english;
    }
  }
}

// you can also write in this way
// class AppLanguages {
//   static const String arabic = "ar";
//   static const String english = "en";
// }
