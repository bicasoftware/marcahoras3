import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/features/empregos/empregos/empregos_tile.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../resources.dart';
import '../../../routes.dart';
import '../../../widgets.dart';

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
      floatingActionButton: empregos.length > 0
          ? FloatingActionButton(
              onPressed: () {
                final detailsBloc = context.read<EmpregosDetailBloc>();
                detailsBloc.reset();

                Navigator.of(context).pushNamed(Routes.empregosDetail);
              },
              child: Icon(Icons.add),
            )
          : null,
      body: empregos.length == 0
          ? NoDataContainer(
              contentLabel: strings.empregosEmpty,
              helperButtonLabel: strings.adicionarEmprego,
              helperButtonTap: () => _showAddEmpregoScreen(context),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ...empregos.map(
                      (e) => GestureDetector(
                        onTap: () {
                          final detailsBloc =
                              context.read<EmpregosDetailBloc>();
                          detailsBloc.setAsEdit(e);
                          Navigator.of(context).pushNamed(
                            Routes.empregosDetail,
                          );
                        },
                        child: CardContainer(
                          label: e.descricao,
                          margin: EdgeInsets.only(bottom: 8),
                          leading: Icon(
                            Icons.work_outline_outlined,
                            color: AppColors.primary,
                          ),
                          trailing: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.edit,
                              color: AppColors.disabled,
                              size: 16,
                            ),
                          ),
                          child: EmpregosTile(
                            descricao: e.descricao,
                            admissao: e.admissao!,
                            salario: 1200,
                            status: e.ativo,
                            porcNormal: e.porcNormal,
                            porcFeriado: e.porcFeriado,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
