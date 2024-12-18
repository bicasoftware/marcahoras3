import 'package:flutter/material.dart';
import 'package:marcahoras3/features/presentation/presentation_carousel_indicator.dart';
import 'package:marcahoras3/resources.dart';

class CarouselNavigator extends StatelessWidget {
  final int currentPos, length;
  final EdgeInsets padding;
  final VoidCallback onBackTapped, onNextTapped, onFinishedTapped;

  const CarouselNavigator({
    required this.length,
    required this.currentPos,
    required this.onBackTapped,
    required this.onNextTapped,
    required this.onFinishedTapped,
    this.padding = const EdgeInsets.all(8),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return Container(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextButton(
              onPressed: currentPos > 0 ? onBackTapped : null,
              child: Text(strings.back),
            ),
          ),
          Expanded(
            flex: 6,
            child: CarouselIndicator(
              length: length,
              currentPos: currentPos,
            ),
          ),
          Expanded(
            flex: 3,
            child: TextButton(
              onPressed: () {
                if (currentPos < length - 1) {
                  onNextTapped();
                } else {
                  onFinishedTapped();
                }
              },
              child: Text(
                currentPos == length - 1 ? strings.confirmar : strings.next,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
