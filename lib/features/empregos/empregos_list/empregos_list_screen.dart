import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/features/empregos/empregos_list/empregos_list_item.dart';
import 'package:marcahoras3/presentation_layer/blocs/home/home_bloc.dart';
import 'package:marcahoras3/presentation_layer/route_args.dart';
import 'package:marcahoras3/widgets.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../routes.dart';
import '../../../utils/localiza/localiza.dart';
import '../../../utils/uuid_factory.dart';

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
      arguments: EmpregosArguments(Empregos(id: UuidFactory.build()), true),
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
    final bloc = context.read<HomeBloc>();
    final empregos = bloc.state.empregos;

    return Scaffold(
      appBar: ShAppBar(label: Localiza.find("empregos")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCreateScreen(context: context),
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: AppColors.secondary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            spacing: 8,
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
                salario: e.salario,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
