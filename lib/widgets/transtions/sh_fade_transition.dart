import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ShPageFadeTransition extends PageRouteBuilder {
  final Widget page;
  ShPageFadeTransition({required this.page, required RouteSettings settings})
    : super(
        pageBuilder: (context, animation, anotherAnimation) => page,
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 300),
        settings: settings,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
      );
}

class ShPageSlideTransition extends PageRouteBuilder {
  final Widget page;
  ShPageSlideTransition({required this.page, required RouteSettings settings})
    : super(
        pageBuilder: (context, animation, anotherAnimation) => page,
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 300),
        settings: settings,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,            
          );
          
        },
      );
}
