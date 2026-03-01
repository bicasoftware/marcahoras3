import 'package:flutter/material.dart';

import 'porcentagens_sliders.dart';

class PorcentagensTile extends StatelessWidget {
  final bool isInsert;
  final int porcNormal, porcFeriado;
  final ValueChanged<int> onNormalPorcChanged, onFeriadoPorcChanged;

  const PorcentagensTile({
    required this.isInsert,
    required this.porcNormal,
    required this.porcFeriado,
    required this.onNormalPorcChanged,
    required this.onFeriadoPorcChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PorcentagemSlider(
      porcNormal: porcNormal,
      porcFeriado: porcFeriado,
      onNormalChanged: onNormalPorcChanged,
      onFeriadoChanged: onFeriadoPorcChanged,
    );
  }
}
