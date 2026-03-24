import 'package:flutter/material.dart';

import '../../../widgets.dart';

class ShPopupListTile extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool hideShadow;
  final Color? outlineColor;
  final List<ShPopupMenuItemData>? popupOptions;

  const ShPopupListTile({
    required this.child,
    required this.popupOptions,
    this.onTap,
    this.hideShadow = false,
    this.outlineColor,
  });

  @override
  State<ShPopupListTile> createState() => _ShDetailedListTileState();
}

class _ShDetailedListTileState extends State<ShPopupListTile> {
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
      items: widget.popupOptions!
          .map(
            (item) => PopupMenuItem<int>(
              child: ShPopupMenuItem(item),
              onTap: item.onPressed,
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
    return ShCard(
      child: widget.child,
      outlineColor: widget.outlineColor,
      hideShadow: widget.hideShadow,
      onTapDown: (details) {
        _tapPosition = details.globalPosition;
      },
      onLongPress: _showCustomMenu,
      onTap: widget.onTap,
    );    
  }
}
