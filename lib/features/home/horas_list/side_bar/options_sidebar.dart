import 'package:flutter/material.dart';

import '../../../../resources.dart';
import '../../../../utils.dart';
import '../../../../widgets/outlined_card.dart';

class OptionsSidebar extends StatelessWidget {
  final VoidCallback onAddTapped, onCalendarTapped, onReportTapped;

  const OptionsSidebar({
    required this.onReportTapped,
    required this.onAddTapped,
    required this.onCalendarTapped,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      cardColor: context.colors.surface,
      outlineColor: context.colors.outline,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            onPressed: onAddTapped,
            backgroundColor: ExtraColors.porcNormalColor,
            child: Icon(Icons.add),
          ),
          FloatingActionButton.small(
            onPressed: onCalendarTapped,
            backgroundColor: ExtraColors.porcNormalColor,
            child: Icon(Icons.calendar_month),
          ),
          FloatingActionButton.small(
            onPressed: onReportTapped,
            backgroundColor: ExtraColors.porcNormalColor,
            child: Icon(Icons.paste),
          ),
        ],
      ),
    );
  }
}
