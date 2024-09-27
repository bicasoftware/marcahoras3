import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../resources.dart';
import '../../../routes.dart';
import '../../../widgets.dart';
import '../home_more_options.dart';

class PopupSessionButton extends StatelessWidget {
  const PopupSessionButton({super.key});

  void _logoff(BuildContext context, RegistrationBloc bloc) async {
    final regBloc = context.read<RegistrationBloc>();

    showLoadingDialog(context: context);
    await regBloc.logout();

    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(Routes.registration);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final bloc = context.read<RegistrationBloc>();

    return PopupMenuButton<HomeMoreOptions>(
      color: AppColors.inversePrimary,
      icon: Icon(Icons.more_vert),
      onSelected: (a) {
        _logoff(context, bloc);
      },
      itemBuilder: (BuildContext context) {
        return HomeMoreOptions.values
            .map(
              (o) => PopupMenuItem(
                child: Text(
                  "Sair",
                  style: theme.labelLarge?.copyWith(color: AppColors.onPrimary),
                ),
                value: HomeMoreOptions.sair,
              ),
            )
            .toList();
      },
    );
  }
}
