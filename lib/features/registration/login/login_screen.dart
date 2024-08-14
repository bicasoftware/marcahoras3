import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/presentation_layer/dialogs/loading_dialog.dart';
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

  Future<void> _validateForm(HomeBloc bloc, BuildContext ctx) async {
    if (_formKey.currentState?.validate() ?? false) {
      showLoadingDialog(context: ctx);
      final logged =
          await bloc.loginIn(emailController.text, passwordController.text);
      Navigator.of(context).pop(ctx);
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
                  title: Text(strings.defaultErro),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(strings.fechar),
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
              onContinuePressed: () => _validateForm(bloc, context),
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
