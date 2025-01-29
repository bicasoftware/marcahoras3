import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../widgets/overtime_list_tile.dart';

class HorasList extends StatefulWidget {
  final bool isList;
  final List<ReportHora> horas;
  final void Function(Horas h) onDelete, onItemTap;

  const HorasList({
    required this.horas,
    required this.onDelete,
    required this.onItemTap,
    this.isList = false,
    super.key,
  });

  @override
  State<HorasList> createState() => _HorasListState();
}

class _HorasListState extends State<HorasList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 8),
      children: widget.horas
          .map(
            (h) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: OvertimeListTile(
                horaType: h.type,
                date: h.date,
                workedHours: h.workedHours,
                amount: h.amount,
                salary: h.salary,
                onTap: () => widget.onItemTap(h.hora),
              ),
            ),
          )
          .toList(),
    );
  }
}
