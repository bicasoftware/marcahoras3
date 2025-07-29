import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../presentation_layer/blocs.dart';
import '../../../presentation_layer/route_args.dart';
import '../../../resources.dart';
import '../../../routes.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import '../widgets/add_hora_bts.dart';

mixin CalendarScreenPresenterMixin {
  void showHorasBts({
    required BuildContext context,
    required HomeBloc bloc,
    Horas? selectedHora,
    DateTime? data,
    bool isEdit = false,
  }) async {
    final locale = Localizations.localeOf(context);
    final now = DateTime.now();
    final newHora = await BottomSheetHelper.showModalBts(
      context: context,
      dismissible: true,
      leading: Container(
        margin: EdgeInsets.only(right: 12),
        child: Icon(Icons.calendar_month),
      ),
      label: !isEdit
          ? Localiza.find("novahora")
          : formatDateByLocale(data, locale),
      trailing: isEdit
          ? OutlinedCard(
              child: IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.deleteColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the current bts
                  onDeleteHora(context, bloc, selectedHora!);
                },
              ),
            )
          : null,
      body: AddHoraBts(
        hora: selectedHora,
        feriado: selectedHora?.tipoHora == HorasType.feriado,
        empregoId: bloc.state.currentEmprego.id!,
        initDate: selectedHora?.data ?? data ?? now,
        empregoEntrada: bloc.state.currentEmprego.entrada,
        hideDate: (selectedHora?.data != null || data != null),
        admissao: bloc.state.currentEmprego.admissao!,
        bancoHoras: bloc.state.currentEmprego.bancoHoras,
        diferencial: bloc.state.currentEmprego.diferenciaisList
            .firstWhereOrNull(
              (d) {                
                final ok = isSameWeekday(d.weekday, data ?? now);
                return ok;
              },
            ),
      ),
    );

    if (newHora != null) {
      isEdit ? bloc.updateHora(newHora) : bloc.insertHora(newHora);
    }
  }

  Future<void> onDeleteHora(
    BuildContext context,
    HomeBloc bloc,
    Horas selectedHora,
  ) async {
    final result = await showConfirmationDialog(
      context: context,
      titleMsg: Localiza.find("confirmar"),
      descriptionText: "Deseja apapgar essa hora extra?",
    );

    if (result == true) {
      bloc.deleteHora(selectedHora);
    }
  }

  void addMonth(BuildContext context, HomeBloc bloc) {
    bloc.incMonth();
  }

  void decMonth(BuildContext context, HomeBloc bloc) {
    bloc.decMonth();
  }

  Future<void> showEmpregosScreen({
    required BuildContext context,
    required HomeBloc bloc,
    required bool isInsert,
  }) async {
    await Navigator.of(context).pushNamed(
      Routes.empregosDetail,
      arguments: isInsert
          ? EmpregosArguments(
              Empregos(
                id: UuidFactory.build(),
              ),
              true,
            )
          : EmpregosArguments(bloc.state.currentEmprego, false),
    );

    bloc.load();
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

  void deleteHora(BuildContext context, Horas h, HomeBloc bloc) async {
    final result = await showConfirmationDialog(
      context: context,
      titleMsg: Localiza.find('confirmar'),
      descriptionText: Localiza.findAndReplace(
        stringKey: 'deleteDialogTitle',
        findString: '{value}',
        replaceWithKey: 'horas',
      ),
    );

    if (result == true) {
      bloc.deleteHora(h);
    }
  }
}
