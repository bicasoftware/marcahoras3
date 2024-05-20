import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/features/home/home.dart';
import 'package:marcahoras3/features/registration/login/login_screen.dart';

import '../../presentation_layer/blocs.dart';
import '../empregos/empregos_screen.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  @override
  void initState() {
    // if (!mounted) return;
    // final b = context.read<HomeBloc>();
    // if (!b.state.hasToken) {
    //   print("don't have token");
    //   Navigator.pushNamed(context, Routes.login);
    // }

    // if (b.state.empregos.isNotEmpty) {
    //   print("don't have empregos");
    //   // TODO - push empregos screen
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final b = context.read<HomeBloc>();
    return Scaffold(
      body: Builder(
        builder: (_) {
          if (!b.state.hasRefreshToken) {
            return const LoginScreen();
          }

          if (b.state.empregos.isEmpty) {
            return const EmpregosScreen();
          }

          return const MyHomePage();
        },
      ),
    );
  }
}
