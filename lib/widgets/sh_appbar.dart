import 'package:flutter/material.dart';

import '../utils.dart';

class ShAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final List<Widget>? actions;
  final double elevation;
  final bool roundedCorner;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;

  const ShAppBar({
    required this.label,
    this.elevation = 1,
    this.roundedCorner = true,
    this.centerTitle = true,
    this.actions,
    this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.primary,
      foregroundColor: context.colors.onPrimary,
      centerTitle: centerTitle,
      title: Text(label),
      elevation: elevation,
      shape: roundedCorner
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            )
          : null,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
