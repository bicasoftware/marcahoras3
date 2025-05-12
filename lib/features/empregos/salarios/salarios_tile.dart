import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import 'salarios_action_type.dart';
import 'salarios_input_tile.dart';
import 'salarios_list.dart';

class SalariosTile extends StatefulWidget {
  final List<Salarios> salarios;
  final ValueChanged<SalariosActionType> onOptionSelected;
  final ValueChanged<String> onSalarioValueChanged;
  final ValueChanged<Salarios> onEdit;
  final ValueChanged<Salarios> onDelete;
  final bool isEditing;
  final MoneyMaskedTextController controller;
  final List<HoraFixo> horaFixoList;

  const SalariosTile({
    required this.salarios,
    required this.onOptionSelected,
    required this.onSalarioValueChanged,
    required this.isEditing,
    required this.controller,
    required this.onEdit,
    required this.onDelete,
    required this.horaFixoList,
    super.key,
  });

  @override
  State<SalariosTile> createState() => _SalariosTileState();
}

class _SalariosTileState extends State<SalariosTile> {
  @override
  Widget build(BuildContext context) {
    return widget.isEditing
        ? SalariosList(
          salarios: widget.salarios,
          onOptionSelected: widget.onOptionSelected,
          onEdit: widget.onEdit,
          onDelete: widget.onDelete,
          horaFixoList: widget.horaFixoList,
        )
        : SalariosInputTile(
          controller: widget.controller,
          onSalarioValueChanged: widget.onSalarioValueChanged,
        );
  }
}
