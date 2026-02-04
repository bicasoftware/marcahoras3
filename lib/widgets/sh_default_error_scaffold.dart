import 'package:flutter/material.dart';

import '../utils.dart';
import '../widgets.dart';

class ShDefaultErrorScaffold extends StatelessWidget {
  final String errorMsg;
  final VoidCallback onRetry;

  const ShDefaultErrorScaffold({
    required this.errorMsg,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CardContainer(
          cardColor: context.colors.surface,
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                errorMsg,
                textAlign: TextAlign.center,
                style: context.textTheme.labelLarge,
              ),
              const SizedBox(height: 16),
              ShFormButton.update(onRetry),
            ],
          ),
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
