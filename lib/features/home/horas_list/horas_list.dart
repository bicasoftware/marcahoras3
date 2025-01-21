import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../widgets/overtime_list_tile.dart';

class HorasList extends StatelessWidget {
  // final List<Horas> horas;
  // final Empregos emprego;
  final List<ReportHora> horas;
  final void Function(Horas h) onDelete, onItemTap;

  const HorasList({
    required this.horas,
    required this.onDelete,
    // required this.emprego,
    required this.onItemTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: horas
            .map(
              (h) => Container(
                margin: EdgeInsets.only(bottom: 8),
                child: OvertimeListTile(
                  horaType: h.type,
                  date: h.date,
                  workedHours: h.workedHours,
                  amount: h.amount,
                  salary: h.salary,
                  onTap: () => onItemTap(h.hora),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
