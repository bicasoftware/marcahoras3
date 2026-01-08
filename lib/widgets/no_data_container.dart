import 'package:flutter/material.dart';

import '../utils.dart';
import '../widgets.dart';

class NoDataContainer extends StatelessWidget {
  final String contentLabel;
  final String helperButtonLabel;
  final void Function() helperButtonTap;

  const NoDataContainer({
    super.key,
    required this.contentLabel,
    required this.helperButtonLabel,
    required this.helperButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CardContainer(
        cardColor: context.colors.surface,
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              contentLabel,
              textAlign: TextAlign.center,
              style: context.textTheme.labelLarge,
            ),
            const SizedBox(height: 16),
            ShWideButton(
              onTap: helperButtonTap,
              labelId: helperButtonLabel,
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
