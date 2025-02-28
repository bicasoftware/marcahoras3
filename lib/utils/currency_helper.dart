import 'dart:io';

import 'package:intl/intl.dart';

class CurrencyHelper {
  static String formatAmount(double amount) {
    return NumberFormat.simpleCurrency(locale: Platform.localeName).format(amount);
  }
}
