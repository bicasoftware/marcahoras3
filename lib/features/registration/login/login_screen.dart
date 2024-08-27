import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../presentation_layer/validators/validators.dart';
import '../../../resources.dart';
import '../../../routes.dart';
import '../../../widgets.dart';
import '../registration_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _validateForm(RegistrationBloc bloc, BuildContext ctx) async {
    if (_formKey.currentState?.validate() ?? false) {
      showLoadingDialog(context: ctx);
      final logged =
          await bloc.loginIn(emailController.text, passwordController.text);
      Navigator.of(context).pop();
      if (logged && mounted) {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      }
    }
  }

  void _goToRegistration(BuildContext c) {
    Navigator.of(c).pushReplacementNamed(Routes.registration);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();
    final strings = context.strings();
    return Scaffold(
      body: RedGradientContainer(
        child: BlocHelper<RegistrationBloc, RegistrationState>(
          bloc: bloc,
          onError: (error) {
            showErrorDialog(
              context: context,
              errorMsg: error,
            );
          },
          child: Form(
            key: _formKey,
            child: RegistrationContainer(
              changeRegisterLabel: strings.naoTenhoCadastro,
              onChangeRegisterPressed: () => _goToRegistration(context),
              onContinuePressed: () => _validateForm(bloc, context),
              child: Column(
                children: [
                  ShTextField(
                    controller: emailController,
                    label: strings.typeEmail,
                    hint: strings.email,
                    validator: (String? s) {
                      return EmailValidator.validate(s, strings);
                    },
                  ),
                  ShTextField(
                    controller: passwordController,
                    label: strings.password,
                    hint: strings.password,
                    validator: (s) {
                      return MinCharactersValidator.validate(
                        passwordController.text,
                        6,
                        strings,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
