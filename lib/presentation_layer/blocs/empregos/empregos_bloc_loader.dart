import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_config.dart';
import '../../../data_layer/respositories.dart';
import '../../../domain_layer/usecases.dart';
import '../../route_args.dart';
import 'empregos_bloc.dart';

class EmpregosBlocLoader extends StatefulWidget {
  final Widget child;

  const EmpregosBlocLoader({required this.child});

  @override
  State<EmpregosBlocLoader> createState() => _EmpregosBlocLoaderState();
}

class _EmpregosBlocLoaderState extends State<EmpregosBlocLoader> {
  @override
  Widget build(BuildContext context) {
    final empregoArgs =
        ModalRoute.of(context)?.settings.arguments as EmpregosArguments;
        
    final empregoRepo = EmpregoRepository(
      provider: AppConfig.shared.empregosProvider!,
      sqlProvider: AppConfig.shared.empregosSqlProvider!,
    );
    final salarioRepo = SalariosRepository(
      provider: AppConfig.shared.salariosProvider!,
      sqlProvider: AppConfig.shared.salariosSqlProvider!,
    );

    final difRepo = DiferenciaisRepository(
      provider: AppConfig.shared.diferenciaisProvider!,
      sqlProvider: AppConfig.shared.diferenciaisSqlProvider!,
    );

    final fixoRepo = HoraFixoRepository(
      provider: AppConfig.shared.fixoProvider!,
      sqlProvider: AppConfig.shared.fixoSqlProvider!,
    );

    return BlocProvider(
      create: (_) => EmpregosBloc(
        insertUseCase: EmpregoInsertUseCase(empregoRepo),
        updateUseCase: EmpregoUpdateUseCase(empregoRepo),
        salariosCreateUseCase: SalarioCreateUseCase(salarioRepo),
        salariosUpdateUseCase: SalarioUpdateUseCase(salarioRepo),
        salariosDeleteUseCase: SalarioDeleteUseCase(salarioRepo),
        diferencialDeleteUseCase: DiferencialDeleteUseCase(difRepo),
        diferencialSaveUseCase: DiferencialSaveUseCase(difRepo),
        diferencialUpdateUseCase: DiferencialUpdateUseCase(difRepo),
        diferencialInsertManyUseCase: DiferencialInsertManyUseCase(difRepo),
        horaFixoDeleteUseCase: HoraFixoDeleteUseCase(fixoRepo),
        horaFixoSaveUseCase: HoraFixoSaveUseCase(fixoRepo),
        horaFixoUpdateUseCase: HoraFixoUpdateUseCase(fixoRepo),
      )..load(emprego: empregoArgs.emprego!, isInsert: empregoArgs.isInsert),
      child: widget.child,
    );
  }
}
