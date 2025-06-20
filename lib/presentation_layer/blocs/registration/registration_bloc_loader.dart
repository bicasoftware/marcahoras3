import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_layer/providers.dart';
import '../../../data_layer/respositories.dart';
import '../../../data_layer/web.dart';
import '../../../domain_layer/usecases.dart';
import 'registration_bloc.dart';

class RegistrationBlocLoader extends StatelessWidget {
  final Widget child;

  const RegistrationBlocLoader({required this.child});

  @override
  Widget build(BuildContext context) {
    final connector = WebConnector();
    final registerRepo = RegistrationRepository(
      provider: RegistrationProvider(connector: connector),
    );
    return BlocProvider(
      child: child,
      create: (_) => RegistrationBloc(
        registerUserUseCase: RegisterUserUsecase(repo: registerRepo),
        loginUserUseCase: LoginUserUsecase(repo: registerRepo),
      ),
    );
  }
}
