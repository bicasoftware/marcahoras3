import 'package:flutter/material.dart';

import '../widgets.dart';


class ShLabeledListSection extends StatelessWidget {
  /// Use the string ID. Don't pass localized already strings
  final String label;
  
  /// Localization is automatic, use only the String Id
  const ShLabeledListSection(this.label);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: ShText(
        label,
        textAlign: TextAlign.start,
        style: theme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
