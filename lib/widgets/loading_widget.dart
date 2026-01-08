import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          child,
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ),
              child: Container(
                color: Colors.black12,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(32),
                    width: context.getWidthByPercent(70),
                    height: context.getHeightByPercent(20),
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
                        CircularProgressIndicator(),
                        Text(Localiza.find('carregando')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
