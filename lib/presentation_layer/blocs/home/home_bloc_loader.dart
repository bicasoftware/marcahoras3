import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_config.dart';
import '../../../data_layer/respositories.dart';
import '../../../domain_layer/usecases.dart';
import '../../blocs.dart';

class HomeBlocLoader extends StatefulWidget {
  final Widget child;

  const HomeBlocLoader({required this.child, super.key});

  @override
  State<HomeBlocLoader> createState() => _HomeBlocLoaderState();
}

class _HomeBlocLoaderState extends State<HomeBlocLoader> {
  /// Date used to generate the first page of each [Salario]
  /// inside the load method inside the [BlocHome] bloc
  final DateTime _initialDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final empregoRepo = EmpregoRepository(
      provider: AppConfig.shared.empregosProvider!,
    );

    final horasRepo = HorasRepository(
      provider: AppConfig.shared.horasProvider!,
    );

    return BlocProvider(
      create: (_) => HomeBloc(
        month: _initialDate.month,
        year: _initialDate.year,
        empregoDeleteUseCase: EmpregoDeleteUseCase(empregoRepo),
        horasLoadByRangeUseCase: HorasLoadByRangeUseCase(horasRepo),
        horasCreateUsecase: HorasCreateUseCase(repo: horasRepo),
        horasDeleteUseCase: HorasDeleteUseCase(repo: horasRepo),
        horasUpdateUseCase: HorasUpdateUseCase(repo: horasRepo),
        empregoDataLoadByVigenciaUseCase: EmpregoDataLoadByVigenciaUseCase(
          empregoRepo,
        ),
      )..load(resync: true),
      child: widget.child,
    );
  }
}
