import 'package:flutter/material.dart';

import '../resources/text_styles.dart';
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
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                errorMsg,
                textAlign: TextAlign.center,
                style: AppTextStyles.regularText.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ShWideButton(
                onTap: onRetry,
                labelId: 'atualizar',
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
