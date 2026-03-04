import 'package:flutter/material.dart';

import '../../utils.dart';

class ShFormFieldIndicator extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const ShFormFieldIndicator({
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Magic [Material] so the Ink widget respect parent bounds
        Material(
          child: Ink(
            child: InkWell(
              child: Container(
                margin: const .only(left: 16),
                child: child,
              ),
              onTap: onTap,
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 6,
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
