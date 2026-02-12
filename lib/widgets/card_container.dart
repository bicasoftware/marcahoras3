import 'package:flutter/material.dart';

import '../utils.dart';
import '../widgets.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color cardColor;
  final Widget? label;
  final Widget? leading;
  final Widget? trailing;
  final bool hasShadow;

  const CardContainer({
    required this.child,
    required this.cardColor,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.hasShadow = true,
    this.label,
    this.leading,
    this.trailing,
    super.key,
  });

  bool get _hasExtras => trailing != null || (label != null) || leading != null;

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      padding: padding,
      margin: margin,
      cardColor: cardColor,
      outlineColor: context.colors.outline,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_hasExtras) ...[
            Row(
              children: [
                if (leading != null)
                  Container(
                    child: leading!,
                    margin: const EdgeInsets.only(left: 16),
                  ),
                if (label != null) ...[
                  const SizedBox(width: 8),
                  label!,
                ],
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: trailing,
                ),
              ],
            ),
            // const Divider(endIndent: 16, indent: 16, height: 2),
            const SizedBox(height: 4),
          ],
          child,
        ],
      ),
    );
  }
}
