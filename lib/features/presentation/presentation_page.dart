import 'package:flutter/material.dart';

import '../../resources.dart';
import '../../widgets.dart';

class PresentationPage extends StatelessWidget {
  final String title, message;
  final Widget child;

  const PresentationPage({
    required this.title,
    required this.message,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16.0),
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomRight,
        colors: [
          Colors.red,
          Colors.red.shade900,
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          child,
          const Spacer(),
          Text(
            "* $message",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.inversePrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
