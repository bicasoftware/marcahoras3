import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets/sh_text.dart';

import '../../utils.dart';

enum ShLabelStyle {
  primaryTitle,
  title,
  subtitle,
  content,
  label,
  value,
  listLabel,
}

class ShFormLabel extends StatelessWidget {
  final String labelId;

  final ShLabelStyle _style;

  const ShFormLabel.title(this.labelId) : _style = ShLabelStyle.title;
  const ShFormLabel.primaryTitle(this.labelId)
    : _style = ShLabelStyle.primaryTitle;
  const ShFormLabel.subtitle(this.labelId) : _style = ShLabelStyle.subtitle;
  const ShFormLabel.content(this.labelId) : _style = ShLabelStyle.content;
  const ShFormLabel.label(this.labelId) : _style = ShLabelStyle.label;
  const ShFormLabel.value(this.labelId) : _style = ShLabelStyle.value;
  const ShFormLabel.listLabel(this.labelId) : _style = ShLabelStyle.listLabel;

  @override
  Widget build(BuildContext context) {
    TextStyle? style;

    switch (_style) {
      case ShLabelStyle.title:
        style = context.textTheme.bodyLarge?.copyWith(
          color: context.colors.onSurface,
          fontWeight: .bold,
          fontSize: 15,
          fontFamily: 'Outfit',
        );
      case ShLabelStyle.primaryTitle:
        style = context.textTheme.bodyLarge?.copyWith(
          color: context.colors.primary,
          fontWeight: .bold,
          fontSize: 15,
        );
      case ShLabelStyle.subtitle:
        style = context.textTheme.labelLarge?.copyWith(
          color: context.colors.primary,
          fontFamily: 'Outfit',
        );
      case ShLabelStyle.content:
        style = context.textTheme.bodyLarge?.copyWith(
          color: context.colors.onSurfaceVariant,
          fontWeight: .bold,
          fontSize: 14,
          fontFamily: 'Outfit',
        );
      case ShLabelStyle.label:
        style = context.textTheme.bodyMedium?.copyWith(
          color: context.colors.onSurfaceVariant,
          fontWeight: .normal,
        );
      case ShLabelStyle.value:
        style = context.textTheme.bodyLarge?.copyWith(
          color: context.colors.primary,
          fontWeight: .bold,
          fontSize: 16,
          fontFamily: 'Outfit',
        );
      case ShLabelStyle.listLabel:
        style = context.textTheme.labelLarge?.copyWith(
          color: context.colors.onSurfaceVariant,
          fontSize: 16,
        );
    }

    return ShText(labelId, style: style);
  }
}
