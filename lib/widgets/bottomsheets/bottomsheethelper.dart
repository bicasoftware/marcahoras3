import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';

class BottomSheetHelper {
  static Future<T?> showModalBts<T>({
    required BuildContext context,
    required Widget body,
    String? title,
    String? subtitle,
    bool useRootNavigation = false,
    Color? bgColor,
    Color? barrierColor,
    bool dismissible = false,
    Radius topRadius = const Radius.circular(24),
    Widget? trailing,
    Widget? leading,
    bool showDragHandle = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      useRootNavigator: useRootNavigation,
      barrierColor: barrierColor ?? Colors.black.withValues(alpha: .7),
      isScrollControlled: true,
      showDragHandle: showDragHandle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: topRadius,
          topRight: topRadius,
        ),
      ),
      builder: (context) => SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ?leading,
                    if (title != null)
                      Text(
                        title,
                        style: context.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    if (trailing != null) ...[
                      const Spacer(),
                      trailing,
                    ],
                    const Divider(),
                  ],
                ),
              ),
              body,
            ],
          ),
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
                            ? context.colors.primary.withAlpha(20)
                            : context.colors.surface,
                        border: Border.all(
                          color: context.colors.primary.withAlpha(20),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          m,
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
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
