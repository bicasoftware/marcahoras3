import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizationHelper on BuildContext {
  AppLocalizations translator() {
    return AppLocalizations.of(this)!;
  }

  // ignore: use_build_context_synchronously
  void showTextSnackbar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
