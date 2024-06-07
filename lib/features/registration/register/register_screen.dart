import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/presentation_layer/blocs/home/home_bloc.dart';
import 'package:marcahoras3/presentation_layer/resources/localizations/strings_data.dart';
import 'package:marcahoras3/presentation_layer/validators/form_validator.dart';
import 'package:marcahoras3/presentation_layer/validators/password_match_validator.dart';
import 'package:marcahoras3/widgets/mr_text_input.dart';

import '../registration_container.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onRegistrationChange;
  const RegisterScreen({
    required this.onRegistrationChange,
    super.key,
  });

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

  Future<void> _register(HomeBloc bloc) async {
    if (_formKey.currentState?.validate() == true) {
      /// TODO - call homebloc
    }
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
            onChangeRegisterPressed: widget.onRegistrationChange,
            onContinuePressed: () => _register(bloc),
            child: Column(
              children: [
                MrTextInput(
                  controller: emailController,
                  label: strings.typeEmail,
                  hint: strings.email,
                  validators: [
                    EmailValidator.validate(emailController.text, strings),
                  ],
                ),
                MrTextInput(
                  controller: passwordController,
                  label: strings.password,
                  hint: strings.password,
                  validators: [
                    MinCharactersValidator.validate(
                      passwordConfirmController.text,
                      6,
                      strings,
                    ),
                    PasswordMatchValidator.validate(
                      passwordController.text,
                      passwordConfirmController.text,
                      strings,
                    )
                  ],
                ),
                MrTextInput(
                  controller: passwordConfirmController,
                  label: strings.typeConfirmPass,
                  hint: strings.password,
                  validators: [
                    MinCharactersValidator.validate(
                        passwordController.text, 6, strings),
                    PasswordMatchValidator.validate(
                      passwordController.text,
                      passwordConfirmController.text,
                      strings,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
