import 'package:flutter/material.dart';
import 'package:marcahoras3/presentation_layer/resources/localizations/strings_data.dart';

import '../../../resources/images.dart';

class RegistrationContainer extends StatelessWidget {
  final Widget child;
  final String changeRegisterLabel;
  final VoidCallback onChangeRegisterPressed, onContinuePressed;

  const RegistrationContainer({
    required this.child,
    required this.changeRegisterLabel,
    required this.onChangeRegisterPressed,
    required this.onContinuePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final strings = context.strings();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Colors.red,
              Colors.red.shade900,
            ],
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      MrImages.logoSmall,
                      fit: BoxFit.fitHeight,
                      height: 120,
                    ),
                    const Divider(
                      color: Colors.white24,
                      height: 32,
                    ),
                    Text(
                      strings.appDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // The child should contain all the text inputs required to login/register
                    child,
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: onContinuePressed,
                      child: Text(
                        strings.continuar,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: onChangeRegisterPressed,
                      child: Text(
                        changeRegisterLabel,
                        textAlign: TextAlign.center,
                        style: theme.labelLarge?.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: theme.labelLarge?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
