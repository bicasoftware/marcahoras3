import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          : SafeArea(
              bottom: true,
              top: !Platform.isIOS,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light.copyWith(
                  systemNavigationBarColor: colors.primary,
                  statusBarColor: colors.primary,
                  systemStatusBarContrastEnforced: false,
                ),
                child: Scaffold(
                  backgroundColor: colors.surface,
                  floatingActionButton: bloc.state.hasReportData()
                      ? FloatingActionButton.extended(
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
                        if (bloc.state.hasEmpregos())
                          Container(
                            color: colors.primary,
                            // Gambiarra pra que a statusbar do iOS fique na cor primary
                            padding: Platform.isIOS
                                ? EdgeInsets.only(
                                    left: 12,
                                    right: 12,
                                    bottom: 2,
                                    top: kToolbarHeight,
                                  )
                                : EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 2,
                                  ),
                            child: Row(
                              spacing: 8,
                              children: [
                                Expanded(
                                  child: OutlinedCard(
                                    cardColor: colors.primary,
                                    outlineColor: colors.onPrimary,
                                    margin: .only(bottom: 2),
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
                                OutlinedCard(
                                  cardColor: colors.primary,
                                  outlineColor: colors.onPrimary,
                                  margin: .only(bottom: 2),
                                  child: TextButton.icon(
                                    iconAlignment: .end,
                                    icon: Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: colors.onPrimary,
                                    ),
                                    label: ShText(
                                      'Empregos',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
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
                        bloc.state.hasReportData()
                            ? Expanded(
                                child: OutlinedCard(
                                  margin: .all(8),
                                  cardColor: colors.surface,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: .symmetric(
                                          horizontal: 16.0,
                                        ),
                                        child: Row(
                                          children: [
                                            ShText(
                                              "horasFeitas",
                                              style: textTheme.bodyLarge
                                                  ?.copyWith(
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
                                      Padding(
                                        padding: .only(bottom: 8),
                                        child: Divider(
                                          color: colors.primary.withAlpha(80),
                                          radius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          height: 1,
                                          indent: 8,
                                          endIndent: 8,
                                        ),
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
                                          onDelete: (h) =>
                                              deleteHora(context, h, bloc),
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
                              )
                            : Expanded(
                                child: Center(
                                  child: IntrinsicHeight(
                                    child: OutlinedCard(
                                      margin: .all(8),
                                      cardColor: colors.surface,
                                      child: ShEmptyListItem(
                                        descriptionId: 'horasMesVazia',
                                        extraDescriptionId:
                                            'horasMesVaziaExtra',
                                        icon: FontAwesomeIcons.calendarPlus,
                                        onAddTap: () => showHorasBts(
                                          context: context,
                                          bloc: bloc,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
