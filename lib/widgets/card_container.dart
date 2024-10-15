import 'package:flutter/material.dart';

import '../resources.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color? bgColor;
  final String? label;
  final Widget? leading;
  final Widget? trailing;
  final bool hasShadow;

  const CardContainer({
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.hasShadow = true,
    this.bgColor,
    this.label,
    this.leading,
    this.trailing,
    super.key,
  });

  bool get _hasExtras =>
      trailing != null || (label?.isNotEmpty ?? false) || leading != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
        padding: padding,
        margin: margin,
        decoration: hasShadow
            ? BoxDecoration(
                color: bgColor ?? AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: AppColors.onSurface.withAlpha(40),
                    // spreadRadius: .2,
                  )
                ],
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  if (label?.isNotEmpty ?? false) ...[
                    const SizedBox(width: 8),
                    Text(
                      label!,
                      style: theme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: trailing,
                  ),
                ],
              ),
              const Divider(endIndent: 16, indent: 16, height: 0),
            ],
            child,
          ],
        ));
  }
}
