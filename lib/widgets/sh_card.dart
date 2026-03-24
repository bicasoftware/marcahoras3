import 'package:flutter/material.dart';

import '../resources.dart';
import '../utils.dart';

class ShCard extends StatelessWidget {
  final bool hideShadow;
  final Color? outlineColor;
  final Color? cardColor;
  final EdgeInsets? padding;
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final void Function(TapDownDetails)? onTapDown;

  const ShCard({
    required this.child,
    this.hideShadow = false,
    this.padding = const .all(8),
    this.outlineColor,
    this.cardColor,
    this.onTap,
    this.onLongPress,
    this.onTapDown,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      clipBehavior: .none,
      elevation: hideShadow ? 0 : .5,

      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: cardColor ?? colors.surfaceContainer,
          border: outlineColor != null
              ? Border.all(color: outlineColor!)
              : null,
        ),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          onTapDown: onTapDown,
          onLongPress: onLongPress,
          onTap: onTap,
          splashColor: ExtraColors.splash,
          child: Padding(
            padding: padding!,
            child: child,
          ),
        ),
      ),
    );
  }
}
