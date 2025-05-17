import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../resources.dart';
import '../../../widgets.dart';

class ShDetailedListTile extends StatefulWidget {
  final String title;
  final String badgeLabel;
  final Color badgeColor;
  final List<IconLabelValue> contentList;
  final VoidCallback? onTap;
  final bool hideShadow;
  final List<String>? optionsList;
  final ValueChanged<int>? onOptionSelected;

  const ShDetailedListTile({
    required this.title,
    required this.badgeLabel,
    required this.badgeColor,
    required this.contentList,
    this.onTap,
    this.hideShadow = false,
    this.optionsList,
    this.onOptionSelected,
    super.key,
  });

  @override
  State<ShDetailedListTile> createState() => _ShDetailedListTileState();
}

class _ShDetailedListTileState extends State<ShDetailedListTile> {
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
          widget.optionsList!
              .mapIndexed(
                (pos, item) => PopupMenuItem<int>(
                  value: pos,
                  child: TextButton(
                    child: Text("$item"),
                    onPressed: () {
                      widget.onOptionSelected!(pos);
                      Navigator.of(context).pop(pos);
                    },
                  ),
                ),
              )
              .toList(),
      position: RelativeRect.fromRect(
        _tapPosition! & const Size(40, 40), // smaller rect, the touch area
        Offset.zero &
            overlay.semanticBounds.size, // Bigger rect, the entire screen
      ),
    );

    // delta would be null if user taps on outside the popup menu
    // (causing it to close without making selection)
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
    return GestureDetector(
      // onTap: widget.onTap,
      onTapDown: (details) {
        _tapPosition = details.globalPosition;
      },
      onLongPress: _showCustomMenu,
      child: OutlinedCard(
        hasShadow: !widget.hideShadow,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        margin: EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: IconLabel(
                    icon: Icon(Icons.date_range, color: AppColors.secondary),
                    label: widget.title,
                    labelColor: AppColors.onSurface,
                  ),
                ),
                Badge(
                  backgroundColor: widget.badgeColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  label: Text(widget.badgeLabel),
                ),
              ],
            ),
            const Divider(),
            ...widget.contentList,
          ],
        ),
      ),
    );
  }
}
