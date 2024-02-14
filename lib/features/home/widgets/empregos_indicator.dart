import 'package:flutter/material.dart';

class CarrouselIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const CarrouselIndicator({
    required this.currentIndex,
    required this.itemCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < itemCount; i++)
          _Indicator(
            isCurrentIndex: i == currentIndex,
          ),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  final bool isCurrentIndex;

  const _Indicator({
    required this.isCurrentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: isCurrentIndex ? 12 : 8,
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
  }
}
