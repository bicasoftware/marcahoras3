import 'package:flutter/material.dart';

import '../utils.dart';

class IndicatorTile extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final bool hideShadow;

  const IndicatorTile({
    required this.child,
    this.hideShadow = false,
    this.onTap,
    super.key,
  });

  final _decorationSize = 4.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Magic [Material] so the Ink widget respect parent bounds
        Material(
          child: Ink(
            decoration: hideShadow
                ? null
                : BoxDecoration(
                    color: context.colors.surface,
                    border: Border.all(
                      color: context.colors.primary.withAlpha(20),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: context.colors.shadow.withAlpha(8),
                        offset: Offset(1, 3),
                      ),
                    ],
                  ),
            child: InkWell(              
              child: child,
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
                topLeft: Radius.circular(_decorationSize),
                bottomLeft: Radius.circular(_decorationSize),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
