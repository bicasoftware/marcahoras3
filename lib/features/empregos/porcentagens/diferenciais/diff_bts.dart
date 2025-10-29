import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets/sh_gridview_tile.dart';

import '../../../../utils.dart';
import '../../../../widgets.dart';

class DiffBts extends StatefulWidget {
  final int porc, weekDay;
  final Color color;
  final void Function(int porc, int weekDay, Color color) onSave;

  const DiffBts({
    required this.porc,
    required this.weekDay,
    required this.color,
    required this.onSave,
  });

  @override
  State<DiffBts> createState() => _DiffBtsState();
}

class _DiffBtsState extends State<DiffBts> {
  late int _weekDay, _porc;
  late Color _color;
  final List<int> _weekDaysList = List.generate(7, (i) => i);
  late final List<String> _weekDaysExt;

  @override
  void initState() {
    _weekDay = widget.weekDay;
    _porc = widget.porc;
    _color = widget.color;
    _weekDaysExt = Localiza.findList('weekDays');

    super.initState();
  }

  void _setPorc(int porc) {
    setState(() {
      _porc = porc;
    });
  }

  void _setWeekDay(int weekDay) {
    setState(() {
      _weekDay = weekDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          Text(
            Localiza.find("addDiferecencial"),
            style: theme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: ShSliderPicker(
                  label: Localiza.find("porcentagem"),
                  value: _porc,
                  onChanged: _setPorc,
                  minValue: 50,
                  maxValue: 300,
                ),
              ),
              ShColorPicker(
                initialColor: Colors.purple,
                onColorSelected: (c) {
                  setState(() {
                    _color = c;
                  });
                },
              ),
            ],
          ),
          ShGridviewTile(
            axisCount: 3,
            items: _weekDaysList,
            initialItem: _weekDay,
            formatItem: <String>(int item) => _weekDaysExt[item],
            onSelected: (t) {
              _setWeekDay(t);
            },
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: ShWideButton(
              onTap: () {
                Navigator.of(context).pop();
                widget.onSave(_porc, _weekDay, _color);
              },
              labelId: "salvar",
            ),
          ),
        ],
      ),
    );
  }
}
