import 'package:flutter/material.dart';

import '../../utils.dart';
import '../../widgets.dart';

class ShFormItem extends StatelessWidget {
  final String labelId;
  final IconData? icon;
  final Color? themeColor;
  final Widget child;
  final VoidCallback? onTap;
  final String? Function<T>(T?)? validator;
  final EdgeInsets? padding;

  final Widget? trailing;

  const ShFormItem({
    required this.labelId,
    required this.icon,
    required this.themeColor,
    required this.child,
    this.padding = const .symmetric(horizontal: 16, vertical: 8),
    this.trailing,
    this.onTap,
    this.validator,
  });

  const ShFormItem.trailling({
    required this.labelId,
    required this.icon,
    required this.themeColor,
    required this.child,
    required this.trailing,
    required this.onTap,
    this.padding = const .symmetric(horizontal: 16, vertical: 8),
    this.validator,
  });

  ShFormItem.noIcon({
    required this.labelId,
    required this.child,
    this.padding = const .symmetric(horizontal: 16, vertical: 8),
    this.validator,
    this.onTap,
    this.trailing,
  }) : this.icon = null,
       this.themeColor = null;

  ShFormItem.clean({
    required this.child,
    this.padding = const .symmetric(horizontal: 16, vertical: 8),
    this.onTap,
    this.validator,
  }) : this.icon = null,
       this.themeColor = null,
       this.labelId = '',
       this.trailing = null;

  @override
  Widget build(BuildContext context) {
    return ShCustomFormField(
      validator: validator,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            OutlinedCard(
              cardColor: context.colors.surfaceContainer,
              padding: padding,
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Row(
                    children: [
                      if (labelId.isNotEmpty) ShFormLabel.title(labelId),
                      if (trailing != null) ...[
                        const Spacer(),
                        trailing!,
                      ],
                    ],
                  ),
                  ListTile(
                    contentPadding: .zero,
                    title: child,
                    leading: icon != null
                        ? ShFormIcon(
                            icon: icon!,
                            themeColor: themeColor!,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
