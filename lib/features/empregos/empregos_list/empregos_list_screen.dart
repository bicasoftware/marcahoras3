import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain_layer/models.dart';
import '../../../presentation_layer/blocs.dart';
import '../../../presentation_layer/route_args.dart';
import '../../../resources.dart';
import '../../../routes.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import 'empregos_list_item.dart';

class EmpregosListScreen extends StatefulWidget {
  const EmpregosListScreen({super.key});

  @override
  State<EmpregosListScreen> createState() => _EmpregosListScreenState();
}

class _EmpregosListScreenState extends State<EmpregosListScreen> {
  Future<void> showEditScreen({
    required BuildContext context,
    required Empregos emprego,
  }) async {
    await Navigator.of(context).pushNamed(
      Routes.empregosDetail,
      arguments: EmpregosArguments(emprego, false),
    );
  }

  Future<void> showCreateScreen({
    required BuildContext context,
  }) async {
    await Navigator.of(context).pushNamed(
      Routes.empregosDetail,
      arguments: EmpregosArguments(Empregos.empty(), true),
    );
  }

  void showOnDeleteDialog(BuildContext context, HomeBloc bloc) async {
    final result = await showConfirmationDialog(
      context: context,
      titleMsg: Localiza.findAndReplace(
        stringKey: 'deleteDialogTitle',
        findString: '{value}',
        replaceWithKey: 'emprego',
      ),
      descriptionText: Localiza.find('deleteDialogMsg'),
    );

    if (result == true) {
      bloc.deleteCurrentEmprego();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final empregos = bloc.state.empregos;

    return ShScaffold(
      appBar: ShAppBar(label: Localiza.find("empregos")),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'FAB',
        label: ShText('adicionar'),
        icon: Icon(Icons.add),
        backgroundColor: ShAppTheme.addButtonColor,
        foregroundColor: ShAppTheme.onAddButtonColor,
        onPressed: () => showCreateScreen(context: context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: empregos.map((e) {
            return EmpregosListItem(
              descricao: e.descricao,
              cargaHoraria: "${e.cargaHoraria}",
              ativo: e.ativo,
              diferenciais: e.diferenciaisList,
              onDelete: () => showOnDeleteDialog(context, bloc),
              onNew: () => showCreateScreen(context: context),
              onEdit: () => showEditScreen(context: context, emprego: e),
              onDesativar: () {},
              porcFeriado: e.porcFeriado,
              porcNormal: e.porcNormal,
              salario: e.getCurrentSalario(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
