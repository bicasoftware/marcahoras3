import 'package:flutter/material.dart';

class ShAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final List<Widget>? actions;
  final double elevation;
  final bool roundedCorner;
  final bool centerTitle;

  const ShAppBar({
    required this.label,
    this.elevation = 1,
    this.roundedCorner = true,
    this.centerTitle = true,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
