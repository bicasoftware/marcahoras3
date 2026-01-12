import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../domain_layer/models.dart';
import '../utils.dart';
import '../widgets.dart';

class ShRadioListTile extends StatefulWidget {
  final String label;
  final Icon icon;
  final CargaHoraria initValue;
  final List<CargaHoraria> cargaHorarias;
  final String Function(CargaHoraria v) mapValue;
  final void Function(CargaHoraria v) onChanged;

  const ShRadioListTile({
    required this.label,
    required this.icon,
    required this.initValue,
    required this.cargaHorarias,
    required this.onChanged,
    required this.mapValue,
  });

  @override
  State<ShRadioListTile> createState() => _ShRadioListTileState();
}

class _ShRadioListTileState extends State<ShRadioListTile> {
  late CargaHoraria selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initValue;
  }

  void onItemSelected(CargaHoraria item) {
    setState(() => selected = item);
    widget.onChanged(item);
  }

  @override
  Widget build(BuildContext context) {
    return IndicatorTile(
      child: ListTile(
        // leading: widget.icon,
        title: Text(
          widget.label,
          textAlign: TextAlign.left,
          style: context.textTheme.labelLarge,
        ),
        subtitle: RadioGroup<CargaHoraria>(
          groupValue: selected,
          onChanged: (i) => onItemSelected(i ?? widget.cargaHorarias.first),
          child: Column(
            children: widget.cargaHorarias.mapIndexed((int i, CargaHoraria v) {
              return RadioListTile<CargaHoraria>(
                contentPadding: .zero,
                title: Text(
                  widget.mapValue(v),
                  style: context.textTheme.bodyMedium,
                ),
                value: v,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}