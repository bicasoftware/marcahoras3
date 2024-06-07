import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/features/home/home.dart';
import 'package:marcahoras3/features/registration/login/login_screen.dart';
import 'package:marcahoras3/features/registration/register/register_screen.dart';

import '../../presentation_layer/blocs.dart';
import '../empregos/empregos_screen.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({
    super.key,
  });

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView>
    with SingleTickerProviderStateMixin {
  bool isRegistration = true;
  late final AnimationController animController;

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(
        milliseconds: 400,
      ),
    )..forward();
    super.initState();
  }

  void toggleRegistrationView() {
    setState(() => isRegistration = !isRegistration);
  }

  Widget _getView(HomeState state) {
    if (!state.hasRefreshToken) {
      if (!isRegistration) {
        return LoginScreen(
          onRegistrationChange: toggleRegistrationView,
        );
      }

      return RegisterScreen(
        onRegistrationChange: toggleRegistrationView,
      );
    }

    if (state.empregos.isEmpty) {
      return const EmpregosScreen();
    }

    return const MyHomePage();
  }

  @override
  Widget build(BuildContext context) {
    final b = context.read<HomeBloc>();
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.red,
      ),
      child: Scaffold(
        body: PageTransitionSwitcher(
          reverse: !isRegistration,
          transitionBuilder: (c, anim, secAnim) {
            return SharedAxisTransition(
              animation: anim,
              secondaryAnimation: secAnim,
              transitionType: SharedAxisTransitionType.scaled,
              child: c,
            );
          },
          child: _getView(b.state),
        ),
      ),
    );
  }
}
