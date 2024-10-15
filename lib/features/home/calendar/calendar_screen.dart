import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/utils/utils.dart';

import '../../../domain_layer/models.dart';
import '../../../presentation_layer/blocs.dart';
import '../../../resources.dart';
import '../../../widgets.dart';
import '../horas_list/horas_list.dart';
import '../widgets/add_hora_bts.dart';
import '../widgets/popup_session.dart';
import 'calendar_page.dart';
import 'calendario_screen_header.dart';
import 'widgets/empregos_dropdown.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  void _showHorasBts({
    required BuildContext context,
    required HomeBloc bloc,
    Horas? selectedHora,
    DateTime? data,
    bool isEdit = false,
  }) async {
    final strings = context.strings();
    final locale = Localizations.localeOf(context);
    final newHora = await BottomSheetHelper.showModalBts(
      context: context,
      dismissible: true,
      label: !isEdit
          ? strings.novahora
          : strings.editHoraReplace.replaceAll(
              "{DATA}",
              formatDateByLocale(data, locale),
            ),
      leading: isEdit
          ? IconButton(
              icon: Icon(Icons.delete_outline, color: AppColors.primary),
              onPressed: () {
                Navigator.of(context).pop(); // Close the current bts
                _onDelete(bloc, selectedHora!);
              },
            )
          : null,
      body: AddHoraBts(
        hora: selectedHora,
        feriado: selectedHora?.tipoHora == HorasType.feriado,
        empregoId: bloc.state.currentEmprego!.id!,
        initDate: selectedHora?.data ?? data ?? DateTime.now(),
        empregoEntrada: bloc.state.currentEmprego!.entrada,
        hideDate: (selectedHora?.data != null || data != null),
      ),
    );

    if (newHora != null) {
      awaitableTask(
        context: context,
        actualTask: () async => isEdit
            ? await bloc.updateHora(newHora)
            : await bloc.insertHora(newHora),
      );
    }
  }

  Future<void> _onDelete(HomeBloc bloc, Horas selectedHora) async {
    final strings = context.strings();
    await awaitableTask(
      context: context,
      requireConfirmation: true,
      confirmationTitle: strings.confirmar,
      confirmationMessage: "Deseja apapgar essa hora extra?",
      actualTask: () => bloc.deleteHora(selectedHora),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final strings = context.strings();

    return Scaffold(
      appBar: ShAppBar(
        label: strings.calendario,
        elevation: 0,
        roundedCorner: false,
        centerTitle: false,
        actions: [
          EmpregosDropdown(),
          PopupSessionButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'plus_button',
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.onSecondary,
        onPressed: () => _showHorasBts(
          context: context,
          bloc: bloc,
        ),
        child: const Icon(Icons.add),
      ),
      body: BlocHelper<HomeBloc, HomeState>(
        bloc: bloc,
        onError: (e) {
          showErrorDialog(
            context: context,
            errorMsg: e,
          );
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CalendarioScreenHeader(
                empregos: bloc.state.empregos,
                empregoPos: bloc.state.empregoPos,
                year: bloc.state.year,
                month: bloc.state.month,
                onMonthAdd: bloc.incMonth,
                onMonthDec: bloc.decMonth,
                onYearChanged: bloc.setYear,
                onMonthChanged: bloc.setMonth,

                /// TODO - implementar
                // onEmpregoChanged: (value) => bloc.setEmpregoPos(value),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CalendarPage(
                  page: bloc.state.currentPage(),
                  onCalendarItemTap: (h, d) async {
                    _showHorasBts(
                      context: context,
                      bloc: bloc,
                      selectedHora: h,
                      data: d,
                      isEdit: h != null,
                    );
                  },
                ),
              ),
              const HorasList(horas: []),
            ],
          ),
        ),
      ),
    );
  }
}
