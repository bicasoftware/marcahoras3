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
    final weekdays = Localiza.findList('fullWeekDays');

    return ShPopupListTile(
      onTap: widget.onEdit,
      popupOptions: ShPopupMenuItemData.defaultOptions(
        onEdit: widget.onEdit,
        onDelete: widget.onDelete,
      ),
      child: OutlinedCard(
        cardColor: colors.surfaceContainer,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                spacing: 4,
                children: [
                  ShFormIcon(icon: Icons.work, themeColor: colors.secondary),
                  ShFormLabel.title(widget.descricao),
                ],
              ),
              const Divider(),
              _EmpregoItem(
                labelId: "salario",
                value: CurrencyHelper.formatAmount(widget.salario),
              ),
              _EmpregoItem(
                labelId: "cargaHoraria",
                value: widget.cargaHoraria,
              ),
              _EmpregoItem(
                labelId: "porcNormal",
                value: "${widget.porcNormal} %",
              ),
              _EmpregoItem(
                labelId: "porcFeriado",
                value: "${widget.porcFeriado} %",
              ),
              if (widget.diferenciais.isNotEmpty) ...<Widget>[
                const Divider(),
                ShFormLabel.title("diferenciais"),
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
      ),
    );
  }
}

class _EmpregoItem extends StatelessWidget {
  final String labelId, value;
  const _EmpregoItem({
    required this.labelId,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ShFormLabel.subtitle(labelId),
        ),
        ShFormLabel.title(value),
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
    return Row(
      spacing: 8,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 8,
        ),
        Expanded(
          child: ShFormLabel.subtitle(weekday),
        ),
        ShFormLabel.title("$percent %"),
      ],
    );
  }
}
