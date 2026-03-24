import 'package:flutter/material.dart';

import '../utils.dart';
import '../widgets.dart';

class ShOvertimeCard extends StatelessWidget {
  final String date;
  final String timeRange;
  final String horasFeitasLabel;
  final String horasFeitas;
  final String valorReceberText;
  final String valorReceber;
  final String badgeText;
  final Color badgeColor;
  final bool hideShadow;
  final VoidCallback? onTap, onLongPress;
  final List<ShPopupMenuItemData>? popupOptions;

  const ShOvertimeCard({
    required this.date,
    required this.timeRange,
    required this.badgeText,
    required this.horasFeitasLabel,
    required this.horasFeitas,
    required this.valorReceberText,
    required this.valorReceber,
    required this.badgeColor,
    this.hideShadow = false,
    this.popupOptions,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ShPopupListTile(
      onTap: onTap,
      popupOptions: popupOptions,
      outlineColor: colors.primaryFixed,
      child: Padding(
        padding: const .symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: .zero,
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: ShFormIcon(
                icon: Icons.calendar_month,
                themeColor: colors.primary,
              ),
              title: ShFormLabel.primaryTitle(date),
              subtitle: ShFormLabel.content(timeRange),
              trailing: Badge(
                backgroundColor: badgeColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                label: ShText(badgeText),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShFormLabel.label(horasFeitasLabel),
                      ShFormLabel.value(horasFeitas),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ShFormLabel.label(valorReceberText),
                      ShFormLabel.value(valorReceber),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
