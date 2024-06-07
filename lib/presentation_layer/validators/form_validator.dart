import '../resources/localizations/strings.dart';

class EmailValidator {
  static String? validate(String? email, StringsContract strings) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email ?? "")) {
      return strings.emailInvalid;
    }

    return null;
  }
}

class MinCharactersValidator {
  static String? validate(String? value, int minChar, StringsContract strings) {
    String? error;

    if (value?.isEmpty == true) {
      error = strings.valueCantBeEmpty;
    } else {
      if ((value?.length ?? 0) < minChar) {
        error = strings.valueAtLeastNCharacter.replaceAll("{N}", "$minChar");
      }
    }

    return error;
  }
}

class FormValidator {
  static String? validateAll(List<String?> values) {
    String? error;

    for (String? value in values) {
      if (value != null) {
        error = value;
        break;
      }
    }

    return error;
  }
}
