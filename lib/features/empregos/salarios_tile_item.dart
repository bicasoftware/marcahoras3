import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../resources.dart';

class SalariosTileItem extends StatefulWidget {
  final String vigencia;
  final String valor;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const SalariosTileItem({
    required this.vigencia,
    required this.valor,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<SalariosTileItem> createState() => _SalariosTileItemState();
}

class _SalariosTileItemState extends State<SalariosTileItem>
    with SingleTickerProviderStateMixin {
  late final SlidableController controller;

  @override
  void initState() {
    controller = SlidableController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return Slidable(
      controller: controller,
      child: SizedBox(
        height: 36,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  color: AppColors.inversePrimary.withAlpha(80),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12),
              color: AppColors.surface,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: <Widget>[
                            _LabelText(strings.valorSalario),
                            const Spacer(),
                            _LabelText(strings.vigencia),
                            const SizedBox(width: 12),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            _ValueText(widget.valor),
                            const Spacer(),
                            _ValueText(widget.vigencia),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.swipe_left, color: Colors.black12),
                    onPressed: () => controller.openEndActionPane(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: AppColors.editColor,
            icon: Icons.edit,
            onPressed: (BuildContext context) => widget.onEdit(),
            flex: 1,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          SlidableAction(
            flex: 1,
            backgroundColor: AppColors.deleteColor,
            icon: Icons.delete,
            borderRadius: BorderRadius.all(Radius.circular(24)),
            onPressed: (context) => widget.onDelete(),
          ),
        ],
      ),
    );
  }
}

class _LabelText extends StatelessWidget {
  final String label;

  const _LabelText(
    String label,
  ) : label = label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Text(
      label,
      style: theme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold, color: AppColors.inversePrimary),
      textAlign: TextAlign.start,
    );
  }
}

class _ValueText extends StatelessWidget {
  final String label;

  const _ValueText(
    String label,
  ) : label = label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Text(
      label,
      style: theme.labelMedium,
    );
  }
}
