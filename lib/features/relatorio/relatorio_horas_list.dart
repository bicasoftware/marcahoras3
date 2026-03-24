import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../domain_layer/models.dart';
import '../../widgets.dart';

class RelatorioHorasList extends StatelessWidget {
  final List<ReportHora> horas;
  final bool bancoHoras;
  final List<Diferenciais> diferenciais;
  final void Function(Horas hora) onEdit, onDelete;

  const RelatorioHorasList({
    required this.horas,
    required this.bancoHoras,
    required this.diferenciais,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: horas.length,
      shrinkWrap: true,
      padding: .symmetric(horizontal: 8, vertical: 2),
      physics: Platform.isAndroid ? BouncingScrollPhysics() : null,
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemBuilder: (_, i) {
        final h = horas[i];
        return OvertimeListTile(
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
          popupOptions: ShPopupMenuItemData.defaultOptions(
            onEdit: () => onEdit(h.hora),
            onDelete: () => onDelete(h.hora),
          ),
        );
      },
    );
  }
}
