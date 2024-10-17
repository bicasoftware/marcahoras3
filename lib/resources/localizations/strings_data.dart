import 'package:flutter/material.dart';

import 'strings.dart';
import 'strings_br.dart';
import 'strings_en.dart';

extension StringsHelper on BuildContext {
  StringsContract strings() {
    final locale = Localizations.localeOf(this);

    switch (locale.countryCode) {
      case "BR":
        return const BrStrings();
      case "en_US":
      default:
        return const EnStrings();
    }
  }
}
