import 'package:flutter/material.dart';

import '../resources.dart';
import '../widgets.dart';

class ContentTile extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onDelete, onUpdate;
  final EdgeInsets? padding, margin;
  final double? borderRadius;

  const ContentTile({
    required this.child,
    required this.title,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.onUpdate,
    this.onDelete,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return OutlinedCard(
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
              Row(
                children: [
                  if (onUpdate != null)
                    OutlinedCard(
                      borderRadius: 2,
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(Icons.edit),
                        onPressed: onUpdate,
                      ),
                    ),
                  if (onDelete != null) ...[
                    const SizedBox(width: 8),
                    OutlinedCard(
                      borderRadius: 2,
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(Icons.delete_outline),
                        onPressed: onDelete,
                      ),
                    ),
                  ]
                ],
              ),
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
    );
  }
}
