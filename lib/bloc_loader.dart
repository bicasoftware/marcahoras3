import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_layer/providers.dart';
import 'data_layer/respositories.dart';
import 'data_layer/web.dart';
import 'domain_layer/usecases.dart';
import 'presentation_layer/blocs.dart';
import 'utils/utils.dart';

class BlocLoader extends StatefulWidget {
  final Widget child;

  const BlocLoader({
    required this.child,
    super.key,
  });

  @override
  State<BlocLoader> createState() => _BlocLoaderState();
}

class _BlocLoaderState extends State<BlocLoader> {
  /// Date used to generate the first page of each [Salario]
  /// inside the load method inside the [BlocHome] bloc
  final DateTime _initialDate = DateTime.now();

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

    final horasProvider = HorasProvider(connector: connector);

    final horasRepo = HorasRepository(provider: horasProvider);

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
          ),
        ),
        BlocProvider(
          create: (_) => HomeBloc(
            month: _initialDate.month,
            year: _initialDate.year,
            empregoDataLoadUseCase: EmpregoDataLoadUseCase(empregoRepo),
            empregoDeleteUseCase: EmpregoDeleteUseCase(empregoRepo),
            horasLoadByRangeUseCase: HorasLoadByRangeUseCase(horasRepo),
            horasCreateUsecase: HorasCreateUseCase(repo: horasRepo),
            horasDeleteUseCase: HorasDeleteUseCase(repo: horasRepo),
            horasUpdateUseCase: HorasUpdateUseCase(repo: horasRepo),
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
      child: widget.child,
    );
  }
}
