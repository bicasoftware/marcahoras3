import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/widgets/dialogs/loading_dialog.dart';
import 'package:marcahoras3/resources/localizations/strings_data.dart';
import 'package:marcahoras3/presentation_layer/validators/form_validator.dart';
import 'package:marcahoras3/presentation_layer/validators/password_match_validator.dart';
import 'package:marcahoras3/widgets/hr_text_input.dart';

import '../../../routes.dart';
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
      final logged = await bloc.
      print("valid form");
    }
  }

  void _goToLogin(BuildContext c) {
    Navigator.of(c).pushReplacementNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    final strings = context.strings();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Colors.red,
              Colors.red.shade900,
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: RegistrationContainer(
            changeRegisterLabel: strings.jaTenhoCadastro,
            onChangeRegisterPressed: () => _goToLogin(context),
            onContinuePressed: () => _register(bloc),
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
    );
  }
}
