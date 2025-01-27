import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain_layer/models.dart';
import '../../../presentation_layer/blocs.dart';
import '../../../resources.dart';
import '../../../routes.dart';
import '../../../utils/utils.dart';
import '../../../widgets.dart';
import '../horas_list/horas_list.dart';
import '../widgets/add_hora_bts.dart';
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
  double dragStartPoint = 0.0;
  final int swipeDistance = 60;

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
      leading: isEdit
          ? Container(
              margin: EdgeInsets.only(right: 12),
              child: Icon(Icons.calendar_month),
            )
          : null,
      label: !isEdit ? strings.novahora : formatDateByLocale(data, locale),
      trailing: isEdit
          ? OutlinedCard(
              child: IconButton(
                icon: Icon(Icons.delete_outline, color: AppColors.deleteColor),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the current bts
                  _onDelete(bloc, selectedHora!);
                },
              ),
            )
          : null,
      body: AddHoraBts(
        hora: selectedHora,
        feriado: selectedHora?.tipoHora == HorasType.feriado,
        empregoId: bloc.state.currentEmprego!.id!,
        initDate: selectedHora?.data ?? data ?? DateTime.now(),
        empregoEntrada: bloc.state.currentEmprego!.entrada,
        hideDate: (selectedHora?.data != null || data != null),
        admissao: bloc.state.currentEmprego!.admissao!,
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

  void _addMonth(HomeBloc bloc) => awaitableTask(
        context: context,
        actualTask: () async => bloc.incMonth(),
      );

  void _decMonth(HomeBloc bloc) => awaitableTask(
        context: context,
        actualTask: () async => bloc.decMonth(),
      );

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final tbarHeight = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: 'plus_button',
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.onSecondary,
            onPressed: () => _showHorasBts(
              context: context,
              bloc: bloc,
            ),
            child: const Icon(Icons.add),
          ),
          if (bloc.state.currentReport().hours.length > 0)
            FloatingActionButton(
              heroTag: "totais_button",
              child: const Icon(Icons.list_alt, color: AppColors.onPrimary),
              backgroundColor: AppColors.inversePrimary,
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.relatorio);
              },
            ),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: BlocHelper<HomeBloc, HomeState>(
          bloc: bloc,
          onError: (e) {
            showErrorDialog(
              context: context,
              errorMsg: e,
            );
          },
          child: GestureDetector(
            onHorizontalDragStart: (details) {
              /// Store the dragging start point
              dragStartPoint = details.globalPosition.dx;
            },
            onHorizontalDragEnd: (details) {
              /// Store the dragging end point
              final dragEndPoint = details.globalPosition.dx;

              final distance = dragStartPoint - dragEndPoint;

              /// If the distance is bigger than [swipeDisance]
              /// if the starting point and ending point is negative, increase a month in the calendar
              /// if the starting point and ending point is positive, decrease a month in the calendar
              if (distance >= swipeDistance || distance <= -swipeDistance) {
                if (distance.isNegative) {
                  _addMonth(bloc);
                } else {
                  _decMonth(bloc);
                }
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: tbarHeight,
                  color: AppColors.inversePrimary,
                ),
                Container(
                  color: AppColors.inversePrimary,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.surface,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: EmpregosDropdown(
                      onAdd: () async {
                        final detailsBloc = context.read<EmpregosDetailBloc>();
                        detailsBloc.reset();

                        await Navigator.of(context).pushNamed(
                          Routes.empregosDetail,
                          arguments: true,
                        );
                        bloc.load();
                      },
                      onEdit: () {
                        final detailsBloc = context.read<EmpregosDetailBloc>();
                        detailsBloc.setAsEdit(bloc.state.currentEmprego!);
                        Navigator.of(context).pushNamed(
                          Routes.empregosDetail,
                          arguments: false,
                        );
                      },
                    ),
                  ),
                ),
                CalendarioScreenHeader(
                  year: bloc.state.year,
                  month: bloc.state.month,
                  onMonthAdd: () => _addMonth(bloc),
                  onMonthDec: () => _decMonth(bloc),
                  onYearChanged: (int y) => awaitableTask(
                    context: context,
                    actualTask: () async => bloc.setYear(y),
                  ),
                  onMonthChanged: (m) => awaitableTask(
                    context: context,
                    actualTask: () async => bloc.setMonth(m),
                  ),
                ),
                CalendarPage(
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
                const SizedBox(height: 16),
                Container(
                  height: 120,
                  margin: EdgeInsets.only(left: 12),
                  child: HorasList(
                    horas: bloc.state.currentReport().hours.take(3).toList(),
                    onDelete: (h) => _deleteHora(h, bloc),
                    onItemTap: (h) {
                      _showHorasBts(
                        context: context,
                        bloc: bloc,
                        selectedHora: h,
                        data: h.data,
                        isEdit: true,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteHora(Horas h, HomeBloc bloc) async {
    await awaitableTask(
      context: context,
      actualTask: () => bloc.deleteHora(h),
      requireConfirmation: true,
      confirmationMessage: "Deseja apagar a Hora Extra?",
    );
  }
}
