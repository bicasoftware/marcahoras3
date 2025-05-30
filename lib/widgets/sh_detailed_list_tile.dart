import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../resources.dart';
import '../../../widgets.dart';

class ShDetailedListTile extends StatefulWidget {
  final String title;
  final String? badgeLabel;
  final Color? badgeColor;
  final List<Widget> contentList;
  final VoidCallback? onTap;
  final bool hideShadow;
  final List<String>? optionsList;
  final ValueChanged<int>? onOptionSelected;

  const ShDetailedListTile({
    required this.title,
    required this.contentList,
    this.hideShadow = false,
    this.badgeLabel,
    this.badgeColor,
    this.onTap,
    this.optionsList,
    this.onOptionSelected,
    super.key,
  });

  @override
  State<ShDetailedListTile> createState() => _ShDetailedListTileState();
}

class _ShDetailedListTileState extends State<ShDetailedListTile> {
  var _tapPosition;

  bool get _showBadge => widget.badgeColor != null || widget.badgeLabel != null;

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
      items: widget.optionsList!
          .mapIndexed(
            (pos, item) => PopupMenuItem<int>(
              value: pos,
              child: TextButton(
                child: Text("$item"),
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onOptionSelected!(pos);
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
    assert(
      (widget.optionsList != null && widget.onOptionSelected != null) ||
          (widget.optionsList == null && widget.onOptionSelected == null),
      "optionsList and onOptionSelected must be provided if you want to use the menu",
    );

    return Ink(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: !widget.hideShadow
            ? [BoxShadow(blurRadius: 1, color: Colors.black26)]
            : null,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        onTapDown: (details) {
          _tapPosition = details.globalPosition;
        },
        onLongPress: _showCustomMenu,
        splashColor: AppColors.primary.withAlpha(20),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: IconLabel(
                      icon: Icon(
                        Icons.date_range,
                        color: AppColors.secondary,
                      ),
                      label: widget.title,
                      labelColor: AppColors.onSurface,
                    ),
                  ),
                  if (_showBadge)
                    Badge(
                      backgroundColor: widget.badgeColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      label: Text(widget.badgeLabel ?? ''),
                    ),
                ],
              ),
              const Divider(),
              ...widget.contentList,
            ],
          ),
        ),
      ),
    );
  }
}
