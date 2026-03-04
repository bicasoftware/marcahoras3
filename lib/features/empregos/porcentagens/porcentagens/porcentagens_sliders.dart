import 'package:flutter/material.dart';

import '../../../../resources.dart';
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
      children: [
        ShFormSlider(
          labelId: "porcNormal",
          padding: .symmetric(horizontal: 16,),
          themeColor: ExtraColors.porcNormalColor,
          value: porcNormal,
          onChanged: onNormalChanged,
          minValue: 50,
          maxValue: 250,
        ),
        ShFormSlider(
          labelId: "porcFeriado",
          padding: .symmetric(horizontal: 16,),
          themeColor: ExtraColors.porcFeriadosColor,
          value: porcFeriado,
          onChanged: onFeriadoChanged,
          minValue: 100,
          maxValue: 300,
        ),
      ],
    );
  }
}
