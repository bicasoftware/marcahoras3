import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../widgets.dart';

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
    return ListView.separated(
      padding: .symmetric(horizontal: 8),
      itemCount: widget.horas.length,
      separatorBuilder: (_, _) => Container(
        height: 8,
      ),
      itemBuilder: (_, i) {
        final h = widget.horas[i];
        return IndicatorTile(
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
            popupOptions: ShPopupMenuItemData.defaultOptions(
              onEdit: () => widget.onEdit(h.hora),
              onDelete: () => widget.onDelete(h.hora),
            ),
          ),
        );
      },      
    );
  }
}
