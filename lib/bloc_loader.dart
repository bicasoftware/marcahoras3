import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_layer/providers.dart';
import 'data_layer/respositories.dart';
import 'data_layer/web.dart';
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
    final connector = WebConnector();

    connector.addInterceptor(
      InvalidUserInterceptor(),
    );

    final vault = Vault();
    connector.token = vault.token;

    final registerRepo = RegistrationRepository(
      provider: RegistrationProvider(connector: connector),
    );

    final empregoRepo = EmpregoRepository(
      EmpregosProvider(connector),
    );

    final salarioRepo = SalariosRepository(
      provider: SalariosProvider(connector: connector),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RegistrationBloc(
            registerUserUseCase: RegisterUserUsecase(repo: registerRepo),
            loginUserUseCase: LoginUserUsecase(repo: registerRepo),
            setVaultDataUseCase: SetVaultDataUsecase(),
            resetVault: ResetVaultUseCase(),
          ),
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
            empregoDeleteUseCase: EmpregoDeleteUseCase(empregoRepo),
          )..load(),
        ),
        BlocProvider(
          create: (_) => EmpregosDetailBloc(
            insertUseCase: EmpregoInsertUseCase(
              empregoRepo,
            ),
            updateUseCase: EmpregoUpdateUseCase(empregoRepo),
            salariosCreateUseCase: SalarioCreateUseCase(salarioRepo),
            salariosUpdateUseCase: SalarioUpdateUseCase(salarioRepo),
            salariosDeleteUseCase: SalarioDeleteUseCase(salarioRepo),
          ),
        ),
      ],
      child: child,
    );
  }
}
