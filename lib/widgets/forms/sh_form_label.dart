import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets/sh_text.dart';

import '../../utils.dart';

class ShFormLabel extends StatelessWidget {
  final String labelId;
  final bool isTitle;

  const ShFormLabel.title(this.labelId) : isTitle = true;
  const ShFormLabel.subtitle(this.labelId) : isTitle = false;

  @override
  Widget build(BuildContext context) {
    return ShText(
      labelId,
      style: isTitle
          ? context.textTheme.bodyLarge?.copyWith(
              color: context.colors.onPrimaryContainer,
              fontWeight: .bold,
              fontSize: 16,
            )
          : context.textTheme.labelLarge?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
    );
  }
}
