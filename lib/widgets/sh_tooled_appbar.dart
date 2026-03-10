import 'package:flutter/material.dart';

import '../utils.dart';

class ShTooledAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget content;
  final bool roundedCorners;

  const ShTooledAppBar({
    required this.content,
    this.roundedCorners = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.primary,
      foregroundColor: context.colors.onPrimary,
      automaticallyImplyLeading: false,
      title: content,
      shape: roundedCorners
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 8);
}
