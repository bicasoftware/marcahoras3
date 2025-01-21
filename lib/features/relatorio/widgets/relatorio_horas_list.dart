import 'package:flutter/material.dart';

import '../../../domain_layer/models/report/report_hora.dart';
import '../../../widgets/overtime_list_tile.dart';

class RelatorioHorasList extends StatelessWidget {
  final List<ReportHora> horas;

  const RelatorioHorasList({
    required this.horas,
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
            date: h.date,
            workedHours: h.workedHours,
            amount: h.amount,
            salary: h.salary,
            onTap: () {},
          ),
        );
      }).toList(),
    );
  }
}
