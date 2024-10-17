import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets.dart';
import '../resources.dart';

class DetailTile extends StatelessWidget {
  final String label, value;
  final Icon icon;

  const DetailTile({
    required this.label,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return IndicatorTile(
      hideShadow: true,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(width: 16),
          icon,
          const SizedBox(width: 16),
          Text(
            label,
            style: theme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: theme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
