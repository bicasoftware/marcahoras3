import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../resources.dart';
import '../../../routes.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import '../horas_list/horas_list.dart';
import 'calendar_page.dart';
import 'calendar_screen_presenter.dart';
import 'calendario_screen_header.dart';
import 'widgets/empregos_dropdown.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with CalendarScreenPresenterMixin {
  double dragStartPoint = 0.0;
  final int swipeDistance = 60;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final tbarHeight = MediaQuery.of(context).viewPadding.top;
    final colors = context.colors;
    final textTheme = context.textTheme;

    return BlocHelper<HomeBloc, HomeState>(
      bloc: bloc,
      hasData: (s) => s.empregos.isEmpty,
      showErrorWidget: true,
      errorWidget: (err) => ShDefaultErrorScaffold(
        errorMsg: err.errorMsg,
        onRetry: () => bloc.load(resync: true),
      ),
      noDataChild: Scaffold(
        body: NoDataContainer(
          contentLabel: Localiza.find("empregosEmpty"),
          helperButtonLabel: Localiza.find("adicionarEmprego"),
          helperButtonTap: () => showEmpregosScreen(
            context: context,
            bloc: bloc,
            isInsert: true,
          ),
        ),
      ),
      child: bloc.state.empregos.isEmpty
          ? Scaffold(body: Container())
          : Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                icon: Icon(Icons.add),
                backgroundColor: ShAppTheme.addButtonColor,
                foregroundColor: ShAppTheme.onAddButtonColor,
                onPressed: () => showHorasBts(
                  context: context,
                  bloc: bloc,
                ),
                label: ShText('hora'),
              ),
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light.copyWith(
                  systemNavigationBarColor: colors.primary,
                ),
                child: AbsorbPointer(
                  absorbing: bloc.state.status is StateLoadingStatus,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// Container de Empregos
                      Container(
                        height: tbarHeight == 0.0 ? 8.0 : tbarHeight,
                        color: colors.primary,
                      ),
                      if (bloc.state.hasEmpregos())
                        Container(
                          color: colors.primary,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            spacing: 8,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: colors.onPrimary.withAlpha(80),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: EmpregosDropdown(
                                    onAdd: () => showEmpregosScreen(
                                      context: context,
                                      bloc: bloc,
                                      isInsert: true,
                                    ),
                                    onEdit: () => showEmpregosScreen(
                                      context: context,
                                      bloc: bloc,
                                      isInsert: false,
                                    ),
                                    onDelete: () =>
                                        showOnDeleteDialog(context, bloc),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: colors.onPrimary.withAlpha(80),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                    ).pushNamed(Routes.empregos);
                                  },
                                  icon: Icon(
                                    Icons.work_history,
                                    color: colors.onPrimary,
                                  ),
                                  label: ShText(
                                    'Empregos',
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: colors.onPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      /// Container de cabeçalho de dias da semana
                      CalendarioScreenHeader(
                        year: bloc.state.year,
                        month: bloc.state.month,
                        yearList: bloc.state.getYears(),
                        onMonthAdd: () => addMonth(context, bloc),
                        onMonthDec: () => decMonth(context, bloc),
                        onYearChanged: bloc.setYear,
                        onMonthChanged: bloc.setMonth,
                      ),
                      Divider(
                        height: 0,
                        color: colors.onPrimary.withAlpha(60),
                        thickness: 2,
                        endIndent: 8,
                        indent: 8,
                      ),
                      Container(
                        padding: .only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(.2, 1.5),
                              blurRadius: .5,
                            ),
                          ],
                        ),
                        child: CalendarPage(
                          diferenciais:
                              bloc.state.currentEmprego.diferenciaisList,
                          page: bloc.state.getCalendarPage(),
                          onCalendarItemTap: (h, d, f) async {
                            showHorasBts(
                              context: context,
                              bloc: bloc,
                              selectedHora: h,
                              data: d,
                              isEdit: h != null,
                              feriado: f,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Card(
                          margin: .all(8),
                          color: colors.surface,
                          elevation: 4,
                          child: Column(
                            children: [
                              Padding(
                                padding: .symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  children: [
                                    ShText(
                                      "horasFeitas",
                                      style: textTheme.bodyLarge?.copyWith(
                                        fontWeight: .bold,
                                        color: colors.onSurface,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.relatorio,
                                        );
                                      },
                                      child: ShText('verTodas'),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              Expanded(
                                child: HorasList(
                                  diferenciais: bloc
                                      .state
                                      .currentEmprego
                                      .diferenciaisList,
                                  isList: true,
                                  bancoHoras: bloc.state.bancoHoras,
                                  horas: bloc.state.reportShortData(),
                                  onDelete: (h) => deleteHora(context, h, bloc),
                                  onEdit: (h) {
                                    showHorasBts(
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
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
