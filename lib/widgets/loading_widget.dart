import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils.dart';
import '../widgets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  final Widget child;

  const LoadingScreen({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  padding: EdgeInsets.all(32),
                  margin: .symmetric(horizontal: 16),
                  height: 140,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    boxShadow: [
                      BoxShadow(blurRadius: 1, color: Colors.black26),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: <Widget>[
                      CircularProgressIndicator(
                        color: colors.primary,
                      ),
                      ShText(
                        'carregando',
                        style: textTheme.labelLarge?.copyWith(
                          color: colors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
