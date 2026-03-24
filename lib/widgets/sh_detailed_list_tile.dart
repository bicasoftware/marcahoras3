import 'package:flutter/material.dart';

import '../../../widgets.dart';
import '../utils.dart';

class ShDetailedListTile extends StatefulWidget {
  final String title;
  final Color? themeColor;
  final List<Widget> contentList;
  final VoidCallback? onTap;
  final bool hideShadow;
  final List<ShPopupMenuItemData>? popupOptions;
  final EdgeInsets? padding;

  const ShDetailedListTile({
    required this.title,
    required this.contentList,
    this.hideShadow = false,
    this.themeColor,
    this.onTap,
    this.popupOptions,
    this.padding,
    super.key,
  });

  @override
  State<ShDetailedListTile> createState() => _ShDetailedListTileState();
}

class _ShDetailedListTileState extends State<ShDetailedListTile> {

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ShPopupListTile(
      outlineColor: colors.primaryFixed,
      child: Padding(
        padding: widget.padding ?? .symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    spacing: 8,
                    children: [
                      ShFormIcon(
                        icon: Icons.date_range,
                        themeColor: context.colors.primary,
                      ),
                      ShFormLabel.title(widget.title),
                    ],
                  ),
                ),                
              ],
            ),
            const Divider(),
            ...widget.contentList,
          ],
        ),
      ),
      onTap: widget.onTap,
      popupOptions: widget.popupOptions,
    );
  }
}
