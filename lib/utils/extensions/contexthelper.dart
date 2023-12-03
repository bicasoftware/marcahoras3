import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizationHelper on BuildContext {
  AppLocalizations translator() {
    return AppLocalizations.of(this)!;
  }
}
