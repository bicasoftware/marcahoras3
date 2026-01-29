import 'package:flutter/material.dart';

import '../../../../utils.dart';
import '../../../../widgets.dart';

class CalendarDateNavigator extends StatefulWidget
    implements PreferredSizeWidget {
  final int year;
  final int month;
  final List<int> yearList;
  final VoidCallback onMonthAdd, onMonthDec;
  final void Function(int year) onYearChanged, onMonthChanged;

  const CalendarDateNavigator({
    required this.year,
    required this.yearList,
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
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final today = DateTime.now();
    final hintedYear = today.year;
    final hintedMonth = Localiza.findList('months')[today.month - 1];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: colors.primary,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: colors.onPrimary,
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
                  Localiza.findList('months')[widget.month - 1],
                  style: textTheme.bodyLarge?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  await BottomSheetHelper.showGridBts(
                    axisCount: 3,
                    context: context,
                    items: Localiza.findList('months'),
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
                  style: textTheme.bodyLarge?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
                onPressed: () async {
                  BottomSheetHelper.showGridBts(
                    context: context,
                    axisCount: 3,
                    items: widget.yearList.map((y) => y.toString()).toList(),
                    hintedItem: hintedYear.toString(),
                    onItemSelected: (pos) {

                      widget.onYearChanged(widget.yearList[pos]);
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
                color: colors.onPrimary,
                size: 16,
              ),
              onPressed: widget.onMonthAdd,
            ),
          ),
        ],
      ),
    );
  }
}
