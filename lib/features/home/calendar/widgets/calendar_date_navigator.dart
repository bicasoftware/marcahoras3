import 'package:flutter/material.dart';

import '../../../../resources.dart';
import '../../../../widgets/bottomsheets/bottomsheethelper.dart';

class CalendarDateNavigator extends StatefulWidget
    implements PreferredSizeWidget {
  final int year;
  final int month;
  final VoidCallback onMonthAdd, onMonthDec;
  final void Function(int year) onYearChanged, onMonthChanged;

  const CalendarDateNavigator({
    required this.year,
    required this.month,
    required this.onMonthAdd,
    required this.onMonthDec,
    required this.onYearChanged,
    required this.onMonthChanged,
    super.key,
  });

  @override
  State<CalendarDateNavigator> createState() => _CalendarDateNavigatorState();

  @override
  Size get preferredSize => const Size.fromHeight(48);
}

class _CalendarDateNavigatorState extends State<CalendarDateNavigator> {
  final _yearList = <String>[];
  late final DateTime today;

  @override
  void initState() {
    super.initState();

    today = DateTime.now();
    for (int i = today.year - 5; i < today.year + 2; i++) {
      _yearList.add("$i");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final strings = context.strings();
    final hintedYear = today.year.toString();
    final hintedMonth = strings.months[today.month-1];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.inversePrimary,
      child: Row(children: [
        Expanded(
          flex: 2,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.onPrimary,
              size: 16,
            ),
            onPressed: widget.onMonthDec,
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: Text(
                strings.months[widget.month - 1],
                style: theme.bodyLarge?.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
              onPressed: () async {
                await BottomSheetHelper.showGridBts(
                  axisCount: 3,
                  context: context,
                  items: strings.months,
                  hintedItem: hintedMonth,
                  onItemSelected: (pos) {
                    widget.onMonthChanged(pos);
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            alignment: Alignment.centerLeft,
            child: TextButton(
              child: Text(
                "${widget.year}",
                style: theme.bodyLarge?.copyWith(
                  color: AppColors.onPrimary,
                ),
                textAlign: TextAlign.end,
              ),
              onPressed: () async {
                BottomSheetHelper.showGridBts(
                  context: context,
                  axisCount: 3,
                  items: _yearList,
                  hintedItem: hintedYear,
                  onItemSelected: (pos) {
                    widget.onYearChanged(int.parse(_yearList[pos]));
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.onPrimary,
              size: 16,
            ),
            onPressed: widget.onMonthAdd,
          ),
        ),
      ]),
    );
  }
}
