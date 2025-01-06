import 'package:flutter/material.dart';

import '../../resources.dart';

class PresentationLogoContainer extends StatelessWidget {
  const PresentationLogoContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                strings.welcomeTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Image.asset(
                AppImages.logoBigTransparent,
                fit: BoxFit.fitWidth,
                height: 200,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                strings.welcomeMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
