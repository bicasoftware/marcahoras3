import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation_layer/blocs/home/home_bloc.dart';

class BlocLoader extends StatelessWidget {
  final Widget child;

  const BlocLoader({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBloc()..load(),
        ),
      ],
      child: child,
    );
  }
}
