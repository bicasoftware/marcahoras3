import 'package:flutter/material.dart';

import '../../../../utils.dart';
import '../../../../widgets.dart';

class PorcentagemSlider extends StatelessWidget {
  final int porcNormal, porcFeriado;
  final ValueChanged<int> onNormalChanged, onFeriadoChanged;

  const PorcentagemSlider({
    required this.porcNormal,
    required this.porcFeriado,
    required this.onNormalChanged,
    required this.onFeriadoChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        ShSliderPicker(
          label: Localiza.find("porcNormal"),
          value: porcNormal,
          onChanged: onNormalChanged,
          minValue: 50,
          maxValue: 250,
        ),
        ShSliderPicker(
          label: Localiza.find("porcFeriado"),
          value: porcFeriado,
          onChanged: onFeriadoChanged,
          minValue: 100,
          maxValue: 300,
        ),
      ],
    );
  }
}
