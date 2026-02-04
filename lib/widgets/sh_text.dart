import 'package:flutter/material.dart';

import '../utils/localiza/localiza.dart';

/// Plain Text widget, but doing the localization by itself
/// Add more stuff as needed.
class ShText extends StatelessWidget {
  final String textId;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;

  const ShText(
    this.textId, {
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      Localiza.find(textId),
      style: style,
      strutStyle:strutStyle,
      textAlign:textAlign,
      textDirection:textDirection,
      locale:locale,
      softWrap:softWrap,
      overflow:overflow,
    );
  }
}
