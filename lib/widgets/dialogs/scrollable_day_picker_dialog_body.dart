import 'package:flutter/material.dart';

import '../../utils.dart';
import '../../widgets.dart';

class ScrollableDayPickerBody extends StatefulWidget {
  final int day;
  final Function(int t) onDaySet;

  const ScrollableDayPickerBody({
    required this.day,
    required this.onDaySet,
  });

  @override
  State<ScrollableDayPickerBody> createState() =>
      _ScrollableDayPickerBodyState();
}

class _ScrollableDayPickerBodyState extends State<ScrollableDayPickerBody> {
  final _days = List<int>.generate(30, (i) => i+1);
  late int selectedDay;

  @override
  void initState() {
    selectedDay = widget.day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            child: Container(
              color: context.colors.surfaceContainerHigh,
              child: ShScrollablePicker<int>(
                items: _days,
                selectedItem: selectedDay,
                valueFormatter: <int>(i) => "$i".padLeft(2, '0'),
                onItemSelected: (int pos) {
                  setState(() => selectedDay = pos);
                  widget.onDaySet(pos+1);
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            Localiza.find('hora'),
            textAlign: TextAlign.start,
            style: context.textTheme.labelLarge!.copyWith(
              color: context.colors.onSurface,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
