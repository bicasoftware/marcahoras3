import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets/sh_text.dart';

import '../../utils.dart';

enum ShLabelStyle { title, subtitle, content }

class ShFormLabel extends StatelessWidget {
  final String labelId;

  final ShLabelStyle _style;

  const ShFormLabel.title(this.labelId) : _style = ShLabelStyle.title;
  const ShFormLabel.subtitle(this.labelId) : _style = ShLabelStyle.subtitle;
  const ShFormLabel.content(this.labelId) : _style = ShLabelStyle.content;

  @override
  Widget build(BuildContext context) {
    TextStyle? style;

    switch (_style) {
      case ShLabelStyle.title:
        style = context.textTheme.bodyLarge?.copyWith(
          color: context.colors.onSurface,
          fontWeight: .bold,
          fontSize: 15,
        );
      case ShLabelStyle.subtitle:
        style = context.textTheme.labelLarge?.copyWith(
          color: context.colors.primary,
        );
      case ShLabelStyle.content:
        style = context.textTheme.bodyLarge?.copyWith(
          color: context.colors.onSurfaceVariant,
          fontWeight: .bold,
          fontSize: 14,
        );
    }

    return ShText(labelId, style: style);
  }
}
