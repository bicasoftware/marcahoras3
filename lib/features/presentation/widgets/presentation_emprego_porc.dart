import 'package:flutter/material.dart';
import 'package:marcahoras3/domain_layer/models.dart';

import '../../../widgets.dart';

class PresentationEmpregoPorc extends StatefulWidget {
  final HorasType tipoHora;
  final int porc;
  final ValueChanged<int> onPorcChanged;

  const PresentationEmpregoPorc({
    required this.tipoHora,
    required this.porc,
    required this.onPorcChanged,
  });

  @override
  State<PresentationEmpregoPorc> createState() =>
      _PresentationEmpregoPorcState();
}

class _PresentationEmpregoPorcState extends State<PresentationEmpregoPorc> {
  int _porc = 0;

  @override
  void initState() {
    _porc = widget.porc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShSliderPicker(
      label: "Porcentagem Dias Normais",
      value: _porc,
      onChanged: (p) {
        setState(() => _porc = p);
        widget.onPorcChanged(p);
      },
      minValue: widget.tipoHora == HorasType.normal ? 50 : 100,
      maxValue: widget.tipoHora == HorasType.normal ? 250 : 300,
    );
  }
}
