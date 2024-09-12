import 'package:flutter/material.dart';

import '../resources.dart';

extension SnackbarUtils on BuildContext {
  void showSnackBar(String msg) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: Theme.of(this).textTheme.labelLarge,
        ),
        elevation: 2,
        backgroundColor: AppColors.onPrimary,
      ),
    );
  }
}
