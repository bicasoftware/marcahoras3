import 'package:flutter/material.dart';
import 'package:marcahoras3/resources/text_styles.dart';

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
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              contentLabel,
              textAlign: TextAlign.center,
              style: AppTextStyles.regularText.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: helperButtonTap,
              label: Text(helperButtonLabel),
              icon: Icon(Icons.add),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
