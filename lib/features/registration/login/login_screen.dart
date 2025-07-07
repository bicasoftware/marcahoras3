import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../presentation_layer/validators/validators.dart';
import '../../../resources.dart';
import '../../../routes.dart';
import '../../../utils.dart';
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
  String _errorMsg = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _validateForm(RegistrationBloc bloc, BuildContext ctx) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _errorMsg = '');
      await bloc.loginIn(
        emailController.text,
        passwordController.text,
      );

      final logged = bloc.state.status is StateSuccessStatus;

      if (logged) {
        await context.read<HomeBloc>().synchDatabase();
        await context.read<HomeBloc>().load();
        Navigator.of(context).pushReplacementNamed(Routes.calendar);
      }
    }
  }

  void _goToRegistration(BuildContext c) {
    Navigator.of(c).pushReplacementNamed(Routes.registration);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    final bloc = context.read<RegistrationBloc>();
    return BlocHelper<RegistrationBloc, RegistrationState>(
      bloc: bloc,
      onError: (e) {
        context.showFloatingMessage(e);
        setState(() => _errorMsg = e);
      },
      child: Scaffold(
        body: RedGradientContainer(
          child: Form(
            key: _formKey,
            child: RegistrationContainer(
              changeRegisterLabel: Localiza.find('naoTenhoCadastro'),
              onChangeRegisterPressed: () => _goToRegistration(context),
              onContinuePressed: () => _validateForm(bloc, context),
              showErrorMsg: true,
              errorMsg: _errorMsg,
              child: Column(
                children: [
                  ShTextField(
                    controller: emailController,
                    label: Localiza.find('typeEmail'),
                    hint: Localiza.find('email'),
                    isOutlined: true,
                    labelStyle: theme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onPrimary,
                    ),
                    validator: (String? s) {
                      return EmailValidator.validate(s);
                    },
                  ),
                  const SizedBox(height: 8),
                  ShTextField(
                    controller: passwordController,
                    label: Localiza.find('password'),
                    hint: Localiza.find('password'),
                    isOutlined: true,
                    labelStyle: theme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onPrimary,
                    ),
                    validator: (s) {
                      return MinCharactersValidator.validate(
                        passwordController.text,
                        6,
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
