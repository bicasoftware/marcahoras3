import 'package:flutter/material.dart';

import '../../resources.dart';
import '../../utils.dart';
import '../../widgets.dart';

class ScrollableTimePickerBody extends StatefulWidget {
  final TimeOfDay? timeOfDay;
  final Function(TimeOfDay t) onTimeSet;

  const ScrollableTimePickerBody({
    super.key,
    this.timeOfDay,
    required this.onTimeSet,
  });

  @override
  State<ScrollableTimePickerBody> createState() =>
      _ScrollableTimePickerBodyState();
}

class _ScrollableTimePickerBodyState extends State<ScrollableTimePickerBody> {
  final hoursOfDay = List<int>.generate(24, (i) => i);
  final minutes = List<int>.generate(60, (i) => i);
  int _selectedMinute = 0;
  int _selectedHour = 0;

  @override
  void initState() {
    if (widget.timeOfDay != null) {
      _selectedHour = widget.timeOfDay!.hour;
      _selectedMinute = widget.timeOfDay!.minute;
    } else {
      final now = DateTime.now();
      _selectedHour = now.hour;
      _selectedMinute = now.minute;
    }

    super.initState();
  }

  TimeOfDay get getTime {
    return TimeOfDay(hour: _selectedHour, minute: _selectedMinute);
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
                        color: Colors.grey[50],
                        child: ShScrollablePicker<int>(
                          items: hoursOfDay,
                          selectedItem: _selectedHour,
                          valueFormatter: <int>(i) => "$i".padLeft(2, '0'),
                          onItemSelected: (int pos) {
                            setState(() => _selectedHour = pos);
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
                        color: Colors.grey[50],
                        child: ShScrollablePicker<int>(
                          items: hoursOfDay,
                          selectedItem: _selectedMinute,
                          valueFormatter: <int>(i) => "$i".padLeft(2, '0'),
                          onItemSelected: (int pos) {
                            setState(() => _selectedMinute = pos);
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
