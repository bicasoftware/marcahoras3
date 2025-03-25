import 'package:flutter/material.dart';

import '../../utils.dart';
import '../../widgets.dart';

class ScrollableTimePickerBody extends StatefulWidget {
  final TimeOfDay? timeOfDay;

  const ScrollableTimePickerBody({super.key, this.timeOfDay});

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

  void _onSave() {
    final resultHora = TimeOfDay(hour: _selectedHour, minute: _selectedMinute);
    Navigator.of(context).pop(resultHora);
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      Localiza.find('hora'),
                      textAlign: TextAlign.center,
                      style: theme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      Localiza.find('minuto'),
                      textAlign: TextAlign.center,
                      style: theme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey[100],
                        child: ShScrollablePicker<int>(
                          items: hoursOfDay,
                          selectedItem: _selectedHour,
                          valueFormatter: <int>(i) => "$i".padLeft(2, '0'),
                          onItemSelected: (int pos) {
                            setState(() => _selectedHour = pos);
                          },
                        ),
                      ),
                    ),
                    Text(":", style: theme.displayLarge,),
                    Expanded(
                      child: Container(
                        color: Colors.grey[100],
                        child: ShScrollablePicker<int>(
                          items: hoursOfDay,
                          selectedItem: _selectedMinute,
                          valueFormatter: <int>(i) => "$i".padLeft(2, '0'),
                          onItemSelected: (int pos) {
                            setState(() => _selectedMinute = pos);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          OutlinedButton.icon(
            onPressed: _onSave,
            icon: Icon(Icons.save_outlined),
            label: Text(Localiza.find('salvar')),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
