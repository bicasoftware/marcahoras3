import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcahoras3/utils.dart';

class ShScaffold extends StatelessWidget {
  final Widget? body, bottomNavigationBar, floatingActionButton;
  final PreferredSizeWidget? appBar;

  const ShScaffold({
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    /// Implement more fields as necessary
    return Container(
      color: colors.surface,
      child: SafeArea(
        top: false,
        bottom: true,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: colors.surface,
            statusBarColor: colors.primary,
            systemStatusBarContrastEnforced: false,
            systemNavigationBarContrastEnforced: true,
            systemNavigationBarIconBrightness: .dark,
            statusBarBrightness: .light,
          ),
          child: Scaffold(
            appBar: appBar,
            bottomNavigationBar: bottomNavigationBar,
            backgroundColor: colors.surface,
            floatingActionButton: floatingActionButton,
            body: body,
          ),
        ),
      ),
    );
  }
}
