import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../presentation_layer/validators/validators.dart';
import '../../../routes.dart';
import '../../../widgets.dart';
import '../../../resources.dart';
import '../registration_container.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    passwordConfirmController.dispose();
    emailController.dispose();

    super.dispose();
  }

  Future<void> _register(RegistrationBloc bloc, BuildContext ctx) async {
    if (_formKey.currentState?.validate() == true) {
      showLoadingDialog(context: ctx);
      final logged = await bloc.register(
        emailController.text,
        passwordConfirmController.text,
      );

      Navigator.of(context).pop();
      if (logged && mounted) {
        Navigator.of(context).pushReplacementNamed(Routes.empregos);
      }
    }
  }

  void _goToLogin(BuildContext c) {
    Navigator.of(c).pushReplacementNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();
    final strings = context.strings();

    return Scaffold(
      body: RedGradientContainer(
        child: BlocHelper<RegistrationBloc, RegistrationState>(
          bloc: bloc,
          onError: (errorMsg) {
            showErrorDialog(context: context, errorMsg: errorMsg);
          },
          child: Form(
            key: _formKey,
            child: RegistrationContainer(
              changeRegisterLabel: strings.jaTenhoCadastro,
              onChangeRegisterPressed: () => _goToLogin(context),
              onContinuePressed: () => _register(bloc, context),
              child: Column(
                children: [
                  HrTextInput(
                    controller: emailController,
                    label: strings.typeEmail,
                    hint: strings.email,
                    validator: (s) {
                      return EmailValidator.validate(
                        emailController.text,
                        strings,
                      );
                    },
                  ),
                  HrTextInput(
                    controller: passwordController,
                    label: strings.password,
                    hint: strings.password,
                    validator: (s) {
                      String? error;

                      error = MinCharactersValidator.validate(
                        passwordConfirmController.text,
                        6,
                        strings,
                      );

                      error ??= PasswordMatchValidator.validate(
                        passwordController.text,
                        passwordConfirmController.text,
                        strings,
                      );

                      return error;
                    },
                  ),
                  HrTextInput(
                    controller: passwordConfirmController,
                    label: strings.typeConfirmPass,
                    hint: strings.password,
                    validator: (s) {
                      String? error;
                      error = MinCharactersValidator.validate(
                        passwordController.text,
                        6,
                        strings,
                      );

                      error ??= PasswordMatchValidator.validate(
                        passwordController.text,
                        passwordConfirmController.text,
                        strings,
                      );

                      return error;
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
