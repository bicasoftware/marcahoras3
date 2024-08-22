import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain_layer/models/empregos.dart';
import '../../presentation_layer/blocs/home/home_bloc.dart';
import '../../resources.dart';

import '../../routes.dart';
import '../../widgets.dart';

class EmpregosScreen extends StatelessWidget {
  const EmpregosScreen({super.key});

  void _showAddEmpregoScreen(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.empregosDetail);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final empregos = bloc.state.empregos;
    final strings = context.strings();

    return Scaffold(
      body: empregos.length == 0
          ? NoDataContainer(
              contentLabel: strings.empregosEmpty,
              helperButtonLabel: strings.adicionarEmprego,
              helperButtonTap: () => _showAddEmpregoScreen(context),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    empregos.length.toString(),
                  ),
                  ...empregos.map(
                    (Empregos emprego) => ListTile(
                      title: Text(emprego.descricao),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
