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

    final TextStyle style;

    switch(_style) {
      case ShLabelStyle.title:
      case ShLabelStyle.subtitle:
      case ShLabelStyle.content:
    }

    final _baseTheme = context.textTheme.bodyLarge?.copyWith(
      color: context.colors.onPrimaryContainer,
      fontWeight: .bold,
      fontSize: 16,
    );
    
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
