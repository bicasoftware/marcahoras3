import 'package:flutter/material.dart';

import '../../../domain_layer/models/report/report_hora.dart';
import 'relatorio_horas_list_tile.dart';

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
          child: RelatorioHorasListTile(hora: h),
        );
      }).toList(),
    );
  }
}
