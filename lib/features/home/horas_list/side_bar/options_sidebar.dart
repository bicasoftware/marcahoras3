import 'package:flutter/material.dart';
import 'package:marcahoras3/resources.dart';
import 'package:marcahoras3/widgets/outlined_card.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            onPressed: onAddTapped,
            backgroundColor: AppColors.porcNormalColor,
            child: Icon(Icons.add),
          ),
          FloatingActionButton.small(
            onPressed: onCalendarTapped,
            backgroundColor: AppColors.porcNormalColor,
            child: Icon(Icons.calendar_month),
          ),
          FloatingActionButton.small(
            onPressed: onReportTapped,
            backgroundColor: AppColors.porcNormalColor,
            child: Icon(Icons.paste),
          ),
        ],
      ),
    );
  }
}
