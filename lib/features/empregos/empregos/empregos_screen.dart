import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'empregos_tile.dart';
import '../../../domain_layer/models.dart';
import '../../../main.dart';
import '../../../utils/utils.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../resources.dart';
import '../../../routes.dart';
import '../../../widgets.dart';

class EmpregosScreen extends StatefulWidget {
  const EmpregosScreen({super.key});

  @override
  State<EmpregosScreen> createState() => _EmpregosScreenState();
}

class _EmpregosScreenState extends State<EmpregosScreen> {
  void _showAddEmpregoScreen(BuildContext context, HomeBloc bloc) async {
    await Navigator.of(context).pushNamed(Routes.empregosDetail);
    bloc.load();
  }

  void _onDelete(BuildContext c, HomeBloc bloc, Empregos e) async {
    final strings = context.strings();
    final response = await showConfirmationDialog(
      context: c,
      titleMsg: strings.confirmar,
      descriptionText: "Deseja Apagar o Emprego?",
    );

    if (response == true && mounted) {
      await showLoadingDialog(context: c);

      await bloc.deleteEmprego(e);

      /// Por algum motivo, dar um pop() no context atual não funciona, provavelmente pq o item já foi removido da tree e rebuildado.
      /// Então usar o context do MaterialApp, funciona
      Navigator.of(navigatorKey.currentContext!).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final empregos = bloc.state.empregos;
    final strings = context.strings();

    return Scaffold(
      appBar: ShAppBar(
        label: strings.empregos,
      ),
      floatingActionButton: empregos.length > 0
          ? FloatingActionButton(
              heroTag: "plus_button",
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.onSecondary,
              onPressed: () async {
                final detailsBloc = context.read<EmpregosDetailBloc>();
                detailsBloc.reset();

                await Navigator.of(context).pushNamed(Routes.empregosDetail);
                bloc.load();
              },
              child: Icon(Icons.add),
            )
          : null,
      body: BlocHelper<HomeBloc, HomeState>(
        bloc: bloc,
        onError: (error) {
          Navigator.of(context).pop();
          context.showSnackBar(error);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: RefreshIndicator(
            onRefresh: () => bloc.load(),
            child: empregos.length == 0
                ? NoDataContainer(
                    contentLabel: strings.empregosEmpty,
                    helperButtonLabel: strings.adicionarEmprego,
                    helperButtonTap: () => _showAddEmpregoScreen(context, bloc),
                  )
                : ListView.builder(
                    itemCount: bloc.state.empregos.length,
                    itemBuilder: (_, index) {
                      final e = bloc.state.empregos[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ContentTile(
                          borderRadius: 2,
                          title: e.descricao,
                          margin: EdgeInsets.only(bottom: 8),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          onDelete: () {
                            _onDelete(context, bloc, e);
                          },
                          onUpdate: () {
                            final detailsBloc =
                                context.read<EmpregosDetailBloc>();
                            detailsBloc.setAsEdit(e);
                            Navigator.of(context).pushNamed(
                              Routes.empregosDetail,
                            );
                          },
                          child: EmpregosTile(
                            descricao: e.descricao,
                            salario: e.getCurrentSalario()!,
                            status: e.ativo,
                            porcNormal: e.porcNormal,
                            porcFeriado: e.porcFeriado,
                            bancoHoras: e.bancoHoras,
                            cargaHoraria: e.cargaHoraria,
                            valorHoraNormal: CalcHelper.calcPorcentagemHora(
                              e.getCurrentSalario()?.valor ?? 0.0,
                              e.cargaHoraria,
                              e.porcNormal,
                            ),
                            valorHoraFeriados: CalcHelper.calcPorcentagemHora(
                              e.getCurrentSalario()?.valor ?? 0.0,
                              e.cargaHoraria,
                              e.porcFeriado,
                            ),
                            admissao: e.admissao!,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
