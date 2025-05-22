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
        ModalRoute.of(context)?.settings.arguments as EmpregosArguments?;
    final empregoRepo = EmpregoRepository(AppConfig.shared.empregosProvider!);
    final salarioRepo = SalariosRepository(
      provider: AppConfig.shared.salariosProvider!,
    );

    final difRepo = DiferenciaisRepository(
      provider: AppConfig.shared.diferenciaisProvider!,
    );

    final fixoRepo = HoraFixoRepository(
      provider: AppConfig.shared.fixoProvider!,
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
        horaFixoDeleteUseCase: HoraFixoDeleteUseCase(fixoRepo),
        horaFixoSaveUseCase: HoraFixoSaveUseCase(fixoRepo),
        horaFixoUpdateUseCase: HoraFixoUpdateUseCase(fixoRepo),
      )..load(empregoArgs?.emprego),
      child: widget.child,
    );
  }
}
