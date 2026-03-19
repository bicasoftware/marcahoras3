import 'package:flutter/material.dart';

import '../widgets.dart';

class ShListItemInfo extends StatelessWidget {
  final String label, value;

  const ShListItemInfo({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(4),
      child: Row(
        children: [
          ShFormLabel.subtitle(label),
          const Spacer(),
          ShFormLabel.content(
            value,
          ),
        ],
      ),
    );
  }
}
