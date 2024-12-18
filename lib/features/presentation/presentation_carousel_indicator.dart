import 'package:flutter/material.dart';

import '../../resources.dart';

class CarouselIndicator extends StatelessWidget {
  final int currentPos, length;

  const CarouselIndicator({
    required this.length,
    required this.currentPos,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length,
          (i) => Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: CircleAvatar(
              backgroundColor:
                  i == currentPos ? AppColors.primary : AppColors.disabled,
              radius: 6,
            ),
          ),
        ),
      ),
    );
  }
}
