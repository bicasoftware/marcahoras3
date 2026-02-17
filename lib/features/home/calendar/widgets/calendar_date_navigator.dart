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
    final colors = Theme.of(context).colorScheme;

    final today = DateTime.now();
    final hintedYear = today.year;
    final hintedMonth = Localiza.findList('months')[today.month - 1];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: colors.primary,
      child: Row(
        mainAxisSize: .max,
        mainAxisAlignment: .spaceEvenly,
        spacing: 8,
        children: [
          Expanded(
            flex: 2,
            child: ShPanelButton.icon(
              icon: Icons.keyboard_arrow_left_outlined,
              onTap: widget.onMonthDec,
            ),
          ),
          Expanded(
            flex: 4,
            child: ShPanelButton.label(
              label: Localiza.findList('months')[widget.month - 1],
              onTap: () async {
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
          Expanded(
            flex: 4,
            child: ShPanelButton.label(
              label: "${widget.year}",
              onTap: () async {
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
          Expanded(
            flex: 2,
            child: ShPanelButton.icon(
              icon: Icons.keyboard_arrow_right_outlined,
              onTap: widget.onMonthAdd,
            ),
          ),
        ],
      ),
    );
  }
}
