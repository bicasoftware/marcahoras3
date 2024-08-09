import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/presentation_layer/resources/localizations/strings_data.dart';
import 'package:marcahoras3/routes.dart';
import 'package:marcahoras3/widgets/bloc_helper.dart';
import 'package:marcahoras3/widgets/hr_text_input.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../presentation_layer/validators/form_validator.dart';
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

  Future<void> _validateForm(HomeBloc bloc) async {
    final formState = _formKey.currentState?.validate();
    if (formState == true) {
      /// TODO - criar dialog de loading antes de chamar essa função
      bloc.loginIn(emailController.text, passwordController.text);
    }
  }

  void _goToRegistration(BuildContext c) {
    Navigator.of(c).pushReplacementNamed(Routes.registration);
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
        child: BlocHelper<HomeBloc, HomeState>(
          bloc: bloc,
          onError: (error) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"),
                    )
                  ],
                  content: Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(error),
                  ),
                );
              },
            );
            print(error);
          },
          child: Form(
            key: _formKey,
            child: RegistrationContainer(
              changeRegisterLabel: strings.naoTenhoCadastro,
              onChangeRegisterPressed: () => _goToRegistration(context),
              onContinuePressed: () => _validateForm(bloc),
              child: Column(
                children: [
                  HrTextInput(
                    controller: emailController,
                    label: strings.typeEmail,
                    hint: strings.email,
                    validator: (String? s) {
                      return EmailValidator.validate(s, strings);
                    },
                  ),
                  HrTextInput(
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
