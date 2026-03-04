import 'package:flutter/material.dart';

import '../../utils.dart';

class ShFormLabelValue extends StatelessWidget {
  final String value;
  const ShFormLabelValue(this.value);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: context.textTheme.labelLarge?.copyWith(
        color: context.colors.onSurfaceVariant,
      ),
    );
  }
}
