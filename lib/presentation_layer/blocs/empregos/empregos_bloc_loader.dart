import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_config.dart';
import '../../../data_layer/respositories.dart';
import '../../blocs.dart';
import '../../route_args.dart';

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
    );
    final salarioRepo = SalariosRepository(
      provider: AppConfig.shared.salariosProvider!,
    );

    final difRepo = DiferenciaisRepository(
      provider: AppConfig.shared.diferenciaisProvider!,
    );

    return BlocProvider(
      create: (_) => EmpregosBloc(
        empregoRepository: empregoRepo,
        diferenciaisRepository: difRepo,
        salariosRepository: salarioRepo,
      )..load(emprego: empregoArgs.emprego, isInsert: empregoArgs.isInsert),
      child: widget.child,
    );
  }
}
