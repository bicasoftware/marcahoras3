import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../widgets/overtime_list_tile.dart';

class HorasList extends StatefulWidget {
  final bool isList;
  final List<ReportHora> horas;
  final void Function(Horas h) onDelete, onItemTap;
  final bool bancoHoras;

  const HorasList({
    required this.horas,
    required this.onDelete,
    required this.onItemTap,
    required this.bancoHoras,
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
      children:
          widget.horas
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                    onTap: () => widget.onItemTap(h.hora),
                  ),
                ),
              )
              .toList(),
    );
  }
}
