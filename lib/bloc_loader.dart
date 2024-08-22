import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/data_layer/web/web.dart';
import 'package:marcahoras3/presentation_layer/blocs/empregos/empregos_detail/empregos_detail_bloc.dart';
import 'package:marcahoras3/realm/realm_connector.dart';

import 'data_layer/providers.dart';
import 'data_layer/respositories.dart';
import 'domain_layer/usecases.dart';
import 'presentation_layer/blocs.dart';
import 'utils/utils.dart';

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
          create: (_) => RegistrationBloc(
              registerUserUseCase: RegisterUserUsecase(repo: registerRepo),
              loginUserUseCase: LoginUserUsecase(repo: registerRepo),
              setVaultDataUseCase: SetVaultDataUsecase(),
              resetVault: ResetVaultUseCase(),
              cleanDataUseCase:
                  CleanDataUseCase(empregoRepository: empregoRepo)),
        ),
        BlocProvider(
          create: (_) => EmpregosBloc(
            empregoDataLoadUseCase: EmpregoDataLoadUseCase(
              empregoRepo,
            ),
            deleteUseCase: EmpregoDeleteUseCase(
              empregoRepo,
            ),
          )..load(fetchData: false),
        ),
        BlocProvider(
          create: (_) => HomeBloc(
            empregoDataLoadUseCase: EmpregoDataLoadUseCase(empregoRepo),
          )..load(),
        ),
        BlocProvider(
          create: (_) => EmpregosDetailBloc(
            insertUseCase: EmpregoInsertUseCase(
              empregoRepo,
            ),
          ),
        ),
      ],
      child: child,
    );
  }
}
