import '../resources/localizations/strings.dart';

class PasswordMatchValidator {
  static String? validate(String? pwd1, String? pwd2, StringsContract strings) {
    if (pwd1 == null || pwd2 == null) {
      return strings.passwordMustNotBeEmpty;
    }

    if (pwd1 == pwd2) return null;

    return strings.passwordMustMatch;
  }
}
