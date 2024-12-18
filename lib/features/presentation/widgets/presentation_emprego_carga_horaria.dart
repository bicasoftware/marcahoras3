import 'package:flutter/material.dart';

import '../../../resources.dart';
import '../../../widgets.dart';

class PresentationEmpregoCargaHoraria extends StatelessWidget {
  final int cargaHoraria;
  final ValueChanged<int> onCargaSelected;

  const PresentationEmpregoCargaHoraria({
    required this.cargaHoraria,
    required this.onCargaSelected,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return ShDropDownButton(
      label: strings.cargaHoraria,
      value: cargaHoraria,
      options: [160, 180, 200, 220],
      onChanged: onCargaSelected,
      icon: Icon(Icons.list),
    );
  }
}
