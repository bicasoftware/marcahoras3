import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../utils.dart';
import '../../../widgets.dart';

class EmpregosListItem extends StatefulWidget {
  final String descricao, cargaHoraria;
  final int porcNormal, porcFeriado;
  final List<Diferenciais> diferenciais;
  final double salario;
  final bool ativo;

  final VoidCallback onEdit, onDelete, onNew, onDesativar;

  const EmpregosListItem({
    required this.descricao,
    required this.cargaHoraria,
    required this.porcNormal,
    required this.porcFeriado,
    required this.diferenciais,
    required this.salario,
    required this.ativo,
    required this.onEdit,
    required this.onDelete,
    required this.onNew,
    required this.onDesativar,
  });

  @override
  State<EmpregosListItem> createState() => _ShDetailedListTileState();
}

class _ShDetailedListTileState extends State<EmpregosListItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final weekdays = Localiza.findList('fullWeekDays');

    return ShPopupListTile(
      onTap: widget.onEdit,
      popupOptions: ShPopupMenuItemData.defaultOptions(
        onEdit: widget.onEdit,
        onDelete: widget.onDelete,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              spacing: 4,
              children: [
                CircleAvatar(
                  backgroundColor: colors.secondary,
                  child: Icon(Icons.work, color: colors.onPrimary),
                ),
                Expanded(
                  child: Text(
                    widget.descricao,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            _EmpregoItem(
              label: Localiza.find("salario"),
              value: CurrencyHelper.formatAmount(widget.salario),
            ),
            _EmpregoItem(
              label: Localiza.find("cargaHoraria"),
              value: widget.cargaHoraria,
            ),
            _EmpregoItem(
              label: Localiza.find("porcNormal"),
              value: "${widget.porcNormal} %",
            ),
            _EmpregoItem(
              label: Localiza.find("porcFeriado"),
              value: "${widget.porcFeriado} %",
            ),
            if (widget.diferenciais.isNotEmpty) ...<Widget>[
              const Divider(),
              ShLabeledListSection("diferenciais"),
              ...widget.diferenciais
                  .map(
                    (d) => _DiferenciaisItem(
                      color: d.color,
                      percent: d.percentage,
                      weekday: weekdays[d.weekday],
                    ),
                  )
                  .toList(),
            ],
          ],
        ),
      ),
    );
  }
}

class _EmpregoItem extends StatelessWidget {
  final String label, value;
  const _EmpregoItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: textTheme.bodyLarge,
          ),
        ),
        Text(
          value,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _DiferenciaisItem extends StatelessWidget {
  final String weekday;
  final int percent;
  final Color color;

  const _DiferenciaisItem({
    required this.weekday,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 8,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            weekday,
            style: textTheme.bodyLarge?.copyWith(color: colors.onSurface),
          ),
        ),
        Text(
          "$percent %",
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
