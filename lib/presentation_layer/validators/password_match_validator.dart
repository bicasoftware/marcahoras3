import '../../utils/localiza/localiza.dart';

class PasswordMatchValidator {
  static String? validate(String? pwd1, String? pwd2) {
    if (pwd1 == null || pwd2 == null) {
      return Localiza.find("passwordMustNotBeEmpty");
    }

    if (pwd1 == pwd2) return null;

    return Localiza.find("passwordMustMatch");
  }
}
