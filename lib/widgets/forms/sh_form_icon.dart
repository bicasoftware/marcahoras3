import 'package:flutter/material.dart';

import '../../utils.dart';

class ShFormIcon extends StatelessWidget {
  final IconData icon;
  final Color themeColor;
  
  const ShFormIcon({
    required this.icon,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: themeColor.withAlpha(180),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const .all(8.0),
        child: Icon(icon, color: colors.onSecondary),
      ),
    );
  }
}
