import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../widgets/overtime_list_tile.dart';

class RelatorioHorasList extends StatelessWidget {
  final List<ReportHora> horas;
  final bool bancoHoras;
  final List<Diferenciais> diferenciais;

  const RelatorioHorasList({
    required this.horas,
    required this.bancoHoras,
    required this.diferenciais,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      children: horas.map((h) {
        return Container(
          margin: EdgeInsets.only(bottom: 8),
          child: OvertimeListTile(
            horaType: h.type,
            horaStatus: h.hora.horaStatus,
            bancoHoras: bancoHoras,
            date: h.date,
            workedHours: h.workedHours,
            amount: h.amount,
            salary: h.salary,
            from: h.from,
            to: h.to,
            diferencial: diferenciais.firstWhereOrNull(
              (d) => d.weekday == h.date.weekday,
            ),
            onTap: () {},
          ),
        );
      }).toList(),
    );
  }
}
