import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets.dart';

import '../../resources.dart';

class PresentationPage extends StatelessWidget {
  final String title, message, image;
  final Widget child;

  const PresentationPage({
    required this.title,
    required this.message,
    required this.image,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(
              color: AppColors.onBackground.withAlpha(20),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: AppColors.shadow.withAlpha(8),
                offset: Offset(1, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  Image.asset(
                    image,
                    fit: BoxFit.fitWidth,
                    height: 200,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "* $message",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  child,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
