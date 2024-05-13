import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/realm/realm_connector.dart';

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

    final empregoRepo = EmpregoRepository(
      EmpregosProvider(realm: realm),
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
