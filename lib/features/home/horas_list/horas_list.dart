import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../widgets/overtime_list_tile.dart';

class HorasList extends StatefulWidget {
  final bool isList;
  final List<ReportHora> horas;
  final void Function(Horas h) onDelete, onEdit;
  final bool bancoHoras;
  final List<Diferenciais> diferenciais;

  const HorasList({
    required this.horas,
    required this.onDelete,
    required this.onEdit,
    required this.bancoHoras,
    required this.diferenciais,
    this.isList = false,
    super.key,
  });

  @override
  State<HorasList> createState() => _HorasListState();
}

class _HorasListState extends State<HorasList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 4,
      children: widget.horas
          .map(
            (h) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: OvertimeListTile(
                horaType: h.type,
                horaStatus: h.hora.horaStatus,
                bancoHoras: widget.bancoHoras,
                date: h.date,
                workedHours: h.workedHours,
                amount: h.amount,
                salary: h.salary,
                from: h.from,
                to: h.to,
                diferencial: widget.diferenciais.firstWhereOrNull(
                  (d) => d.weekday == h.date.weekday,
                ),
                onOptionSelected: (value) {
                  if (value == 0) {
                    widget.onEdit(h.hora);
                  } else {
                    widget.onDelete(h.hora);
                  }
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
