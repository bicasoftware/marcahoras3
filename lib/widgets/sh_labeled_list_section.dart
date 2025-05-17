import 'package:flutter/material.dart';

class ShLabeledListSection extends StatelessWidget {
  final String label;

  const ShLabeledListSection({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Text(
        label,
        textAlign: TextAlign.start,
        style: theme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
