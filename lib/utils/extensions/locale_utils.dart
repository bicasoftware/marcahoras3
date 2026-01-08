import 'package:flutter/widgets.dart';

extension LocaleHelper on BuildContext {
  Locale get locale => Localizations.localeOf(this);
}