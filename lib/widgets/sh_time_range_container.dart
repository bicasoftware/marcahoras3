import 'package:flutter/material.dart';

import '../presentation_layer/validators/validators.dart';
import '../utils.dart';
import '../widgets.dart';

class ShTimeRangeContainer extends StatefulWidget {
  final TimeOfDay startTime, endTime;
  final void Function(TimeOfDay time) onStartTimeSet, onEndTimeSet;

  const ShTimeRangeContainer({
    required this.startTime,
    required this.endTime,
    required this.onStartTimeSet,
    required this.onEndTimeSet,
  });

  @override
  State<ShTimeRangeContainer> createState() => _ShTimeRangeContainerState();
}

class _ShTimeRangeContainerState extends State<ShTimeRangeContainer> {
  late TimeOfDay _startTime = widget.startTime;
  late TimeOfDay _endTime = widget.endTime;

  @override
  void initState() {
    _startTime = widget.startTime;
    _endTime = widget.endTime;
    super.initState();
  }

  void _showTimePickerDialog({
    required BuildContext context,
    required TimeOfDay time,
    required bool isEntrada,
  }) async {
    final newTime = await DialogHelper.showTimePickerDialog(
      context: context,
      time: time,
    );

    if (newTime != null && newTime != time) {
      setState(() => isEntrada ? _startTime = newTime : _endTime = newTime);
      if (isEntrada) {
        widget.onStartTimeSet(newTime);
        setState(() => _startTime = newTime);
      } else {
        widget.onEndTimeSet(newTime);
        setState(() => _endTime = newTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      spacing: 4,
      children: [
        Expanded(
          child: LabelFormField<TimeOfDay>(
            label: findText("entradaHora"),
            themeColor: colors.primary,
            initialValue: _startTime,
            valueFormatter: (t) => TimeOfDayHelper.formatTime(t),
            icon: Icons.timelapse_outlined,
            onTap: () async {
              _showTimePickerDialog(
                context: context,
                isEntrada: true,
                time: _startTime,
              );
            },
            validator: (t) {
              return TimeRangeValidator.validate(
                initTime: _startTime,
                endTime: _endTime,
              );
            },
          ),
        ),
        Expanded(
          child: LabelFormField<TimeOfDay>(
            label: Localiza.find("saidaHora"),
            themeColor: Colors.red,
            initialValue: _endTime,
            valueFormatter: (t) {
              return TimeOfDayHelper.formatTime(t);
            },
            icon: Icons.timelapse_outlined,
            onTap: () {
              _showTimePickerDialog(
                context: context,
                isEntrada: false,
                time: _endTime,
              );
            },
            validator: (t) {
              return TimeRangeValidator.validate(
                initTime: _startTime,
                endTime: _endTime,
              );
            },
          ),
        ),
      ],
    );
  }
}
