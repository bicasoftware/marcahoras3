import 'package:flutter/material.dart';
import 'package:marcahoras3/utils/localiza/localiza.dart';

import '../../../widgets.dart';
import 'porcentagens_sliders.dart';
import 'valor_fixo_inputs.dart';

class PorcentagensTile extends StatelessWidget {
  final bool isInsert;
  final bool useValorFixo;
  final ValueChanged<bool> toggleType;
  final (double, double) fixedValues;
  final int porcNormal, porcFeriado;
  final void Function(double, double) onValueChanged;
  final ValueChanged<int> onNormalPorcSet, onFeriadoPorcSet;

  const PorcentagensTile({
    required this.isInsert,
    required this.useValorFixo,
    required this.toggleType,
    required this.onValueChanged,
    required this.fixedValues,
    required this.porcNormal,
    required this.porcFeriado,
    required this.onNormalPorcSet,
    required this.onFeriadoPorcSet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        ShSwitchTile(
          value: useValorFixo,
          label: Localiza.find("valoresFixos"),
          onTap: toggleType,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child:
              useValorFixo
                  ? ValorFixoInputs(
                    onNormalChanged: (v) {
                      onValueChanged(v, fixedValues.$2);
                    },
                    onFeriadoChanged: (v) {
                      onValueChanged(fixedValues.$1, v);
                    },
                    initNormalValue: fixedValues.$1,
                    initFeriadoValue: fixedValues.$2,
                    canEdit: isInsert,
                  )
                  : PorcentagemSlider(
                    porcNormal: porcNormal,
                    porcFeriado: porcFeriado,
                    onNormalChanged: onNormalPorcSet,
                    onFeriadoChanged: onFeriadoPorcSet,
                  ),
        ),
      ],
    );
  }
}
