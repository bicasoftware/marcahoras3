import 'package:flutter/material.dart';

import '../../../widgets.dart';
import '../resources.dart';

class ShPopupListTile extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool hideShadow;
  final List<ShPopupMenuItemData>? popupOptions;

  const ShPopupListTile({
    required this.child,
    required this.onTap,
    required this.popupOptions,
    this.hideShadow = false,
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
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      shadowColor: Colors.black,
      clipBehavior: .none,
      elevation: 2,
      child: Ink(
        child: InkWell(
          onTapDown: (details) {
            _tapPosition = details.globalPosition;
          },
          onLongPress: _showCustomMenu,
          onTap: widget.onTap,
          splashColor: ExtraColors.splash,
          child: widget.child,
        ),
      ),
    );
  }
}
