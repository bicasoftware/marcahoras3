import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ShPageFadeTransition extends PageRouteBuilder {
  final Widget page;
  ShPageFadeTransition({required this.page})
    : super(
        pageBuilder: (context, animation, anotherAnimation) => page,
        transitionDuration: Duration(milliseconds: 1000),
        reverseTransitionDuration: Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
      );
}

