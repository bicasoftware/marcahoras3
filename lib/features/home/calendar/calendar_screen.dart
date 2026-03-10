import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../presentation_layer/blocs.dart';
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
    final colors = context.colors;

    return bloc.state.hasEmpregos()
        ? ShScaffold(
            appBar: ShTooledAppBar(
              content: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.onPrimaryFixedVariant,
                        borderRadius: .all(.circular(8)),
                      ),
                      child: EmpregosDropdown(),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: colors.onPrimaryFixedVariant,
                      borderRadius: .all(.circular(8)),
                    ),
                    child: TextButton.icon(
                      iconAlignment: .end,
                      icon: Icon(
                        Icons.keyboard_arrow_right_rounded,
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
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(Routes.empregos);
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: bloc.state.hasReportData()
                ? FloatingActionButton.extended(
                    heroTag: 'FAB',
                    icon: Icon(Icons.add),
                    label: ShText('hora'),
                    backgroundColor: colors.primaryFixed,
                    foregroundColor: colors.onPrimaryFixed,
                    onPressed: () => showHorasBts(
                      context: context,
                      bloc: bloc,
                    ),
                  )
                : null,
            body: AbsorbPointer(
              absorbing: bloc.state.status is StateLoadingStatus,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                  Container(
                    padding: .symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: colors.primary,
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
                      diferenciais: bloc.state.currentEmprego.diferenciaisList,
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
                    child: ShFeatureCard(
                      cardLabelId: "horasFeitas",
                      seeMoreLabelId: "verTodas",
                      hasData: bloc.state.hasReportData(),
                      isOutlined: bloc.state.hasReportData(),
                      noDataLabelId: 'horasMesVazia',
                      noDataExtraLabelId: 'horasMesVaziaExtra',
                      noDataIcon: FontAwesomeIcons.calendarPlus,
                      onSeeMoreTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.relatorio,
                        );
                      },
                      noDataTap: () => showHorasBts(
                        context: context,
                        bloc: bloc,
                      ),
                      child: Hero(
                        tag: Routes.relatorio,
                        child: HorasList(
                          diferenciais:
                              bloc.state.currentEmprego.diferenciaisList,
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
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            color: colors.primary,
          );
  }
}
