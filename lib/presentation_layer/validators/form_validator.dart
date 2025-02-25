import '../../utils/localiza/localiza.dart';

class EmailValidator {
  static String? validate(String? email) {
    if (email != null || email!.isNotEmpty) {
      final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        return "* ${Localiza.find("emailInvalid")}";
      }
    }

    return null;
  }
}

class MinCharactersValidator {
  static String? validate(String? value, int minChar) {
    String? error;

    if (value?.isEmpty == true) {
      error = Localiza.find("valueCantBeEmpty");
    } else {
      if ((value?.length ?? 0) < minChar) {
        error = Localiza.find(
          "valueAtLeastNCharacter",
        ).replaceAll("{N}", "$minChar");
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

    return "* $error";
  }
}
