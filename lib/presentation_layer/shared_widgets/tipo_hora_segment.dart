import 'package:flutter/material.dart';

import '../../strings.dart';

class TipoHoraSegment extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onTypeChanged;

  const TipoHoraSegment({
    required this.initialValue,
    required this.onTypeChanged,
    super.key,
  });

  @override
  State<TipoHoraSegment> createState() => _TipoHoraSegmentState();
}

class _TipoHoraSegmentState extends State<TipoHoraSegment> {
  static const types = {'n', 'f'};
  Set<String> value = {types.first};

  @override
  void initState() {
    super.initState();
    value = {widget.initialValue};
  }

  void setSelection(Set<String> s) {
    setState(() => value = s);
    widget.onTypeChanged(s.single);
  }

  bool get isNormalHora => value.single == types.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(Strings.tipoHora),
        const SizedBox(
          height: 8,
        ),
        Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: isNormalHora ? Colors.lightBlue : Colors.red,
            ),
          ),
          child: SegmentedButton(
            multiSelectionEnabled: false,
            emptySelectionAllowed: false,
            showSelectedIcon: false,
            selectedIcon: const Icon(Icons.watch_later_outlined),
            segments: [
              ButtonSegment<String>(
                value: types.first,
                label: const Text(Strings.horaNormal),
              ),
              ButtonSegment(
                value: types.last,
                label: const Text(Strings.horaFeriado),
              ),
            ],
            selected: value,
            onSelectionChanged: setSelection,
          ),
        ),
      ],
    );
  }
}
