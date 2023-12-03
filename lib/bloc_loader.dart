import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    final client = Supabase.instance.client;

    final empregoRepo = EmpregoRepository(
      EmpregosProvider(client),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBloc(
            EmpregoDataLoadUseCase(
              empregoRepo,
            ),
            EmpregoInsertUseCase(
              empregoRepo,
            ),
            EmpregoDeleteUseCase(
              empregoRepo,
            ),
          )..load(),
        ),
      ],
      child: child,
    );
  }
}
