import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class CurrencyHelper {
  static String formatAmount(double amount) {
    final _loc = Localizations.localeOf(navigatorKey.currentState!.context);
    return NumberFormat.currency(locale: _loc.toLanguageTag())
        .format(amount)
        .replaceAll("BRL", "R\$");
  }
}
