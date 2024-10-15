import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../resources.dart';

class BottomSheetHelper {
  static Future<T?> showModalBts<T>({
    required BuildContext context,
    required Widget body,
    String? label,
    bool useRootNavigation = false,
    Color? bgColor,
    Color? barrierColor,
    bool dismissible = false,
    Radius topRadius = const Radius.circular(24),
  }) {
    final theme = Theme.of(context).textTheme;

    return showModalBottomSheet<T>(
      context: context,
      useRootNavigator: useRootNavigation,
      barrierColor: barrierColor ?? Colors.black.withOpacity(.7),
      showDragHandle: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: topRadius,
          topRight: topRadius,
        ),
      ),
      builder: (context) => Material(
        color: bgColor,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (label != null)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        label,
                        style: theme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.inversePrimary,
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              body,
            ],
          ),
          padding: MediaQuery.of(context).viewInsets,
        ),
      ),
    );
  }

  static Future<int?> showGridBts({
    required BuildContext context,
    required void Function(int pos) onItemSelected,
    required List<String> items,
    required String hintedItem,
    required int axisCount,
    bool useRootNavigation = false,
    bool dismissible = false,
    Radius topRadius = const Radius.circular(12),
  }) {
    final theme = Theme.of(context).textTheme;
    return showModalBts<int?>(
      context: context,
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(),
            GridView.count(
              crossAxisCount: axisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 3.1,
              children: items.mapIndexed(
                (int i, String m) {
                  return GestureDetector(
                    onTap: () {
                      onItemSelected(i);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: m == hintedItem
                            ? AppColors.inversePrimary.withAlpha(20)
                            : AppColors.surface,
                        border: Border.all(
                          color: AppColors.inversePrimary.withAlpha(20),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          m,
                          textAlign: TextAlign.center,
                          style: theme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
