import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import 'relatorio_horas_list_tile.dart';

class RelatorioHorasList extends StatelessWidget {
  final List<Horas> horas;
  final Empregos emprego;
  final void Function(Horas h) onDelete, onItemTap;
  final String label;

  const RelatorioHorasList({
    required this.horas,
    required this.onDelete,
    required this.emprego,
    required this.onItemTap,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(8),
      children: horas.map((h) {
        return GestureDetector(
          onTap: () => onItemTap(h),
          child: Container(
            margin: EdgeInsets.only(bottom: 8),
            child: RelatorioHorasListTile(
              hora: h,
              emprego: emprego,
            ),
          ),
        );
      }).toList(),
    );
  }
}
