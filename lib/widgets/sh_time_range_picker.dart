import 'package:flutter/material.dart';

import '../resources.dart';
import '../utils/utils.dart';
import '../widgets.dart';
import 'dialogs/dialog_helper.dart';

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
    final strings = context.strings();

    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ShLabeledTile(
            value: _entrada.asString(),
            label: strings.das,
            icon: Icons.timelapse,
            onTap: () async {
              final time = await DialogHelper.showTimeDialog(
                context: context,
                time: _entrada,
              );

              if (time != null && time != _entrada) {
                setState(() => _entrada = time);
                widget.onEntradaChanged(time);
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 5,
          child: ShLabeledTile(
            value: _saida.asString(),
            label: strings.ate,
            icon: Icons.timelapse,
            onTap: () async {
              final time = await DialogHelper.showTimeDialog(
                context: context,
                time: _saida,
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
