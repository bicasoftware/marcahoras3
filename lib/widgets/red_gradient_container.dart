import 'package:flutter/material.dart';

class RedGradientContainer extends StatelessWidget {
  final Widget child;

  const RedGradientContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: child,
    );
  }
}
