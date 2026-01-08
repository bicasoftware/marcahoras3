import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
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
  var _tapPosition;

  void _showCustomMenu() async {
    if (_tapPosition == null) {
      return;
    }
    final overlay = Overlay.of(context).context.findRenderObject();
    if (overlay == null) {
      return;
    }

    final delta = await showMenu(
      context: context,
      items:
          [
                Localiza.find("editar"),
                Localiza.find("apagar"),
                Localiza.find("desativar"),
              ]
              .mapIndexed(
                (pos, item) => PopupMenuItem<int>(
                  value: pos,
                  child: TextButton(
                    child: Text("$item"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      switch (pos) {
                        case 0:
                          () => widget.onEdit;
                        case 1:
                          () => widget.onDelete;
                        case 2:
                          () => widget.onDesativar;
                      }
                    },
                  ),
                ),
              )
              .toList(),
      position: RelativeRect.fromRect(
        _tapPosition! & const Size(40, 40),
        Offset.zero & overlay.semanticBounds.size,
      ),
    );

    if (delta == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final weekdays = Localiza.findList('fullWeekDays');
    return Ink(
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [BoxShadow(blurRadius: 1, color: Colors.black38)],
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        onTapDown: (details) {
          _tapPosition = details.globalPosition;
        },
        onLongPress: _showCustomMenu,
        onTap: widget.onEdit,
        splashColor: ExtraColors.splash,
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
                  PopupMenuButton(
                    color: colors.surface,
                    icon: Icon(
                      Icons.more_vert,
                      color: colors.onSurface,
                    ),
                    itemBuilder: (context) {
                      return <PopupMenuItem>[
                        PopupMenuItem(
                          onTap: widget.onEdit,
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(Icons.edit, color: Colors.teal),
                              Text(
                                Localiza.find('editar'),
                                textAlign: TextAlign.justify,
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colors.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          onTap: widget.onDelete,
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              Text(
                                Localiza.find('apagar'),
                                textAlign: TextAlign.justify,
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colors.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
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
                ShLabeledListSection(label: Localiza.find("diferenciais")),
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
