import 'package:flutter/material.dart';

import '../../../widgets.dart';
import '../utils.dart';

class ShDetailedListTile extends StatefulWidget {
  final String title;
  final String? badgeLabel;
  final Color? badgeColor;
  final List<Widget> contentList;
  final VoidCallback? onTap;
  final bool hideShadow;
  final List<ShPopupMenuItemData>? popupOptions;
  final EdgeInsets? padding;

  const ShDetailedListTile({
    required this.title,
    required this.contentList,
    this.hideShadow = false,
    this.badgeLabel,
    this.badgeColor,
    this.onTap,
    this.popupOptions,
    this.padding,
    super.key,
  });

  @override
  State<ShDetailedListTile> createState() => _ShDetailedListTileState();
}

class _ShDetailedListTileState extends State<ShDetailedListTile> {
  bool get _showBadge => widget.badgeColor != null || widget.badgeLabel != null;

  @override
  Widget build(BuildContext context) {
    return ShPopupListTile(
      hideShadow: false,
      child: Padding(
        padding: widget.padding ?? .symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: 
                  Row(
                    spacing: 8,
                    children: [
                      ShFormIcon(icon: Icons.date_range, themeColor: context.colors.primary),
                      ShFormLabel.title(widget.title),
                    ],
                  )                  
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
      onTap: widget.onTap,
      popupOptions: widget.popupOptions,
    );
  }
}