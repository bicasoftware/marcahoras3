import 'package:flutter/material.dart';

class BottomSheetHelper {
  static Future<T?> showModalBts<T>({
    required BuildContext context,
    required Widget body,
    bool useRootNavigation = false,
    Color? bgColor,
    Color? barrierColor,
    bool dismissible = false,
    Radius topRadius = const Radius.circular(12),
  }) {
    return showModalBottomSheet<T>(
      context: context,
      useRootNavigator: useRootNavigation,
      barrierColor: barrierColor ?? Colors.black.withOpacity(.7),
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            24.0,
          ),
          topRight: Radius.circular(
            24.0,
          ),
        ),
      ),
      builder: (context) => Material(
        color: bgColor,
        child: Container(
          child: body,
          padding: MediaQuery.of(context).viewInsets,
        ),
      ),
    );
  }
}
