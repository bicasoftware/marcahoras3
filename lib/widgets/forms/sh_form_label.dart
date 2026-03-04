import 'package:flutter/material.dart';
import 'package:marcahoras3/utils/extensions/theme_utils.dart';
import 'package:marcahoras3/widgets/sh_text.dart';

class ShFormLabel extends StatelessWidget {
  final String labelId;
  final bool _content;

  const ShFormLabel.title(this.labelId) : _content = true;
  const ShFormLabel.subtitle(this.labelId) : _content = false;

  @override
  Widget build(BuildContext context) {
    return ShText(
      labelId,
      style: _content
          ? context.textTheme.bodyLarge?.copyWith(
              color: context.colors.onPrimaryFixedVariant,
              fontWeight: .bold,
              fontSize: 16
            )
          : context.textTheme.labelLarge?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
    );
  }
}
