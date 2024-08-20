import 'package:flutter/material.dart';

import '../resources.dart';


class CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color? bgColor;
  final String? extrasButtonText;
  final VoidCallback? onExtraTap;

  const CardContainer({
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.extrasButtonText,
    this.onExtraTap,
    this.bgColor,
    super.key,
  });

  bool get _hasExtras =>
      extrasButtonText != null && extrasButtonText!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.surface,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: AppColors.onSurface.withAlpha(40),
              // spreadRadius: .2,
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            if (_hasExtras) ...[
              Row(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TextButton(
                      onPressed: onExtraTap,
                      child: Text(extrasButtonText ?? ''),
                    ),
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
