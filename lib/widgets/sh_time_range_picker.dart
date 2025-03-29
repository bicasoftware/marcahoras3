import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets/dialogs/scrollable_time_picker_dialog.dart';

import '../utils.dart';
import '../widgets.dart';

class ShTimeRangePicker extends StatefulWidget {
  final TimeOfDay initTime, endTime;
  final void Function(TimeOfDay time) onEntradaChanged, onSaidaChanged;

  const ShTimeRangePicker({
    required this.initTime,
    required this.endTime,
    required this.onEntradaChanged,
    required this.onSaidaChanged,
    super.key,
  });

  @override
  State<ShTimeRangePicker> createState() => _ShTimeRangePickerState();
}

class _ShTimeRangePickerState extends State<ShTimeRangePicker> {
  late TimeOfDay _entrada, _saida;

  @override
  void initState() {
    _entrada = widget.initTime;
    _saida = widget.endTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          flex: 5,
          child: ShLabeledTile(
            value: TimeOfDayHelper.formatTime(_entrada),
            label: Localiza.find('das'),
            icon: Icons.timelapse,
            onTap: () async {
              final time = await showScrollableTimePickerDialog(
                context: context,
                titleMsg: Localiza.find('selecionarHorario'),
                descriptionText: '',
                timeOfDay: _entrada,
              );

              if (time != null && time != _entrada) {
                setState(() => _entrada = time);
                widget.onEntradaChanged(time);
              }
            },
          ),
        ),
        Expanded(
          flex: 5,
          child: ShLabeledTile(
            value: TimeOfDayHelper.formatTime(_saida),
            label: Localiza.find('ate'),
            icon: Icons.timelapse,
            onTap: () async {
              final time = await showScrollableTimePickerDialog(
                context: context,
                titleMsg: Localiza.find('selecionarHorario'),
                descriptionText: '',
                timeOfDay: _saida,
                startAt: _entrada,
              );
              if (time != null && time != _saida) {
                setState(() => _saida = time);
                widget.onSaidaChanged(time);
              }
            },
          ),
        ),
      ],
    );
  }
}
