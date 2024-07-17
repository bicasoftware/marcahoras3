import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/data_layer/web/web.dart';
import 'package:marcahoras3/realm/realm_connector.dart';
import 'package:marcahoras3/utils/utils.dart';

import 'data_layer/providers.dart';
import 'data_layer/respositories.dart';
import 'domain_layer/usecases.dart';
import 'presentation_layer/blocs/home/home_bloc.dart';

class BlocLoader extends StatelessWidget {
  final Widget child;

  const BlocLoader({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final realm = RealmConnector().realm;
    final connector = WebConnector();
    final vault = Vault();
    connector.token = vault.token;

    final registerRepo = RegistrationRepository(
      provider: RegistrationProvider(connector: connector),
    );

    final empregoRepo = EmpregoRepository(
      EmpregosProvider(
        realm: realm,
        connector: connector,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBloc(
            empregoLoadUseCase: EmpregoDataLoadUseCase(
              empregoRepo,
            ),
            empregoInsertUseCase: EmpregoInsertUseCase(
              empregoRepo,
            ),
            empregoDeleteUseCase: EmpregoDeleteUseCase(
              empregoRepo,
            ),
            setVaultDataUseCase: const SetVaultDataUsecase(),
            loginUserUsecase: LoginUserUsecase(repo: registerRepo),
            registerUserUsecase: RegisterUserUsecase(repo: registerRepo),
          )..load(),
        ),
      ],
      child: child,
    );
  }
}
