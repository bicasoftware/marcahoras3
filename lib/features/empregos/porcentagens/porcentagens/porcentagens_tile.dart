import 'package:flutter/material.dart';

import '../../../../domain_layer/models.dart';
import '../../../../utils/localiza/localiza.dart';
import '../../../../utils/typedefs.dart';
import '../../../../widgets.dart';
import 'porcentagens_sliders.dart';
import '../valor_fixo/valor_fixo_inputs.dart';
import '../valor_fixo/valor_fixo_tile.dart';

class PorcentagensTile extends StatelessWidget {
  final bool isInsert;
  final bool useValorFixo;
  final ValueChanged<bool> toggleType;
  final ValorFixo fixedValues;
  final int porcNormal, porcFeriado;
  final List<HoraFixo> horaFixoList;
  final VoidCallback onAdd;
  final ValueChanged<(double, double)> onHoraFixoChanged;
  final ValueChanged<int> onNormalPorcChanged, onFeriadoPorcChanged;
  final ValueChanged<HoraFixo> onEdit, onDelete;

  const PorcentagensTile({
    required this.horaFixoList,
    required this.isInsert,
    required this.useValorFixo,
    required this.toggleType,
    required this.onHoraFixoChanged,
    required this.fixedValues,
    required this.porcNormal,
    required this.porcFeriado,
    required this.onNormalPorcChanged,
    required this.onFeriadoPorcChanged,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  Widget _getInputView() {
    if (useValorFixo) {
      if (isInsert) {
        return ValorFixoInputs(
          onNormalChanged: (v) {
            onHoraFixoChanged((v, fixedValues.$2));
          },
          onFeriadoChanged: (v) {
            onHoraFixoChanged((fixedValues.$1, v));
          },
          initNormalValue: fixedValues.$1,
          initFeriadoValue: fixedValues.$2,
          canEdit: isInsert,
        );
      }

      return ValorFixoList(
        horaFixoList: horaFixoList,
        onAdd: onAdd,
        onEdit: onEdit,
        onDelete: onDelete,
      );
    }

    return PorcentagemSlider(
      porcNormal: porcNormal,
      porcFeriado: porcFeriado,
      onNormalChanged: onNormalPorcChanged,
      onFeriadoChanged: onFeriadoPorcChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isInsert)
          ShSwitchTile(
            value: useValorFixo,
            label: Localiza.find("valoresFixos"),
            onTap: toggleType,
          )
        else
          ShLabeledListSection("valorFixo"),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _getInputView(),
        ),
      ],
    );
  }
}
