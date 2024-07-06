import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/presentation_layer/blocs/home/home_bloc.dart';
import 'package:marcahoras3/presentation_layer/resources/localizations/strings_data.dart';
import 'package:marcahoras3/utils/bloc/base_state.dart';
import 'package:marcahoras3/utils/bloc/state_status.dart';
import 'package:marcahoras3/widgets/bloc_watcher.dart';
import 'package:marcahoras3/widgets/mr_text_input.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../presentation_layer/validators/form_validator.dart';
import '../../../widgets.dart';
import '../registration_container.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onRegistrationChange;

  const LoginScreen({
    required this.onRegistrationChange,
    super.key,
  });

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

  Future<void> _validateForm(HomeBloc bloc) async {
    if (_formKey.currentState?.validate() == true) {
      /// TODO - criar dialog de loading antes de chamar essa função
      bloc.loginIn(emailController.text, passwordController.text);
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
        child: BlocWatcher<HomeBloc, HomeState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: RegistrationContainer(
                changeRegisterLabel: strings.naoTenhoCadastro,
                onChangeRegisterPressed: widget.onRegistrationChange,
                onContinuePressed: () => _validateForm(bloc),
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
                          passwordController.text,
                          6,
                          strings,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
