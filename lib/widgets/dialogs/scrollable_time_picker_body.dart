import 'package:flutter/material.dart';

import '../../resources.dart';
import '../../utils.dart';
import '../../widgets.dart';

class ScrollableTimePickerBody extends StatefulWidget {
  final TimeOfDay timeOfDay;
  final TimeOfDay? startAt, endAt;
  final Function(TimeOfDay t) onTimeSet;

  const ScrollableTimePickerBody({
    super.key,
    required this.timeOfDay,
    this.startAt,
    this.endAt,
    required this.onTimeSet,
  });

  @override
  State<ScrollableTimePickerBody> createState() =>
      _ScrollableTimePickerBodyState();
}

class _ScrollableTimePickerBodyState extends State<ScrollableTimePickerBody> {
  final _minutes = List<int>.generate(60, (i) => i);
  var _hours = <int>[];
  late int _minutePos;
  late int _hourPos;

  @override
  void initState() {
    final startHour = widget.startAt?.hour ?? 0;
    final endHour = widget.endAt?.hour ?? 24;
    for (int i = startHour; i <= endHour; i++) {
      _hours.add(i);
    }

    _hourPos = _hours.indexWhere((h) => h == widget.timeOfDay.hour);
    _minutePos = _minutes.indexWhere((m) => m == widget.timeOfDay.minute);

    super.initState();
  }

  TimeOfDay get getTime {
    return TimeOfDay(hour: _hours[_hourPos], minute: _minutes[_minutePos]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColors.surfaceSecondary,
                        child: ShScrollablePicker<int>(
                          items: _hours,
                          selectedItem: _hours[_hourPos],
                          valueFormatter: <int>(i) => "$i".padLeft(2, '0'),
                          onItemSelected: (int pos) {
                            setState(() => _hourPos = pos);
                            widget.onTimeSet(getTime);
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Text(
                          ":",
                          style: theme.bodyLarge!.copyWith(fontSize: 40),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: AppColors.surfaceSecondary,
                        child: ShScrollablePicker<int>(
                          items: _minutes,
                          selectedItem: _minutePos,
                          valueFormatter: <int>(i) => "$i".padLeft(2, '0'),
                          onItemSelected: (int pos) {
                            setState(() => _minutePos = pos);
                            widget.onTimeSet(getTime);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      Localiza.find('hora'),
                      textAlign: TextAlign.start,
                      style: theme.labelLarge!.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      Localiza.find('minuto'),
                      textAlign: TextAlign.start,
                      style: theme.labelLarge!.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
