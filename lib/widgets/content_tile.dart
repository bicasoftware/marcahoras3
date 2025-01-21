import 'package:flutter/material.dart';

import '../resources.dart';
import '../widgets.dart';

class ContentTile extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onDelete;
  final EdgeInsets? padding, margin;
  final double? borderRadius;
  final VoidCallback? onTap;

  const ContentTile({
    required this.child,
    required this.title,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.onDelete,
    this.borderRadius,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: OutlinedCard(
        borderRadius: borderRadius ?? 8,
        padding: padding,
        margin: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: theme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (onDelete != null) ...[
                  const SizedBox(width: 8),
                  OutlinedCard(
                    borderRadius: 2,
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.delete_outline,
                        color: AppColors.primary,
                      ),
                      onPressed: onDelete,
                    ),
                  ),
                ],
              ],
            ),
            // const SizedBox(height: 16),
            const Divider(
              thickness: .1,
              color: AppColors.disabled,
              height: 32,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
