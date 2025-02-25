import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_config.dart';
import 'data_layer/providers.dart';
import 'data_layer/respositories.dart';
import 'data_layer/web.dart';
import 'domain_layer/usecases.dart';
import 'presentation_layer/blocs.dart';
import 'utils.dart';

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
    final empregoRepo = EmpregoRepository(
      AppConfig.shared.empregosProvider!,
    );
    final salarioRepo = SalariosRepository(
      provider: AppConfig.shared.salariosProvider!,
    );
    final horasRepo = HorasRepository(
      provider: AppConfig.shared.horasProvider!,
    );

    return MultiBlocProvider(
      providers: [
        if (AppConfig.shared.flavor == Flavor.online) _buildRegistrationBloc(),
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

  /// Building the whole whatnots of this BlocProvider separately
  /// so it doesn't mess with offline version of the app
  BlocProvider _buildRegistrationBloc() {
    final connector = WebConnector();

    connector.addInterceptor(
      InvalidUserInterceptor(),
    );

    final vault = Vault();
    connector.token = vault.token;

    final registerRepo = RegistrationRepository(
      provider: RegistrationProvider(connector: connector),
    );
    return BlocProvider(
      create: (_) => RegistrationBloc(
        registerUserUseCase: RegisterUserUsecase(repo: registerRepo),
        loginUserUseCase: LoginUserUsecase(repo: registerRepo),
        setVaultDataUseCase: SetVaultDataUsecase(),
        resetVault: ResetVaultUseCase(),
      ),
    );
  }
}
