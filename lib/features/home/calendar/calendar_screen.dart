import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../resources.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import '../horas_list/horas_list.dart';
import 'calendar_page.dart';
import 'calendar_screen_actions.dart';
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
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light.copyWith(
                  systemNavigationBarColor: Colors.transparent,
                ),
                child: AbsorbPointer(
                  /// If the state is loading, don't allow the user to click anything else
                  absorbing: bloc.state.status is StateLoadingStatus,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: tbarHeight == 0.0 ? 8.0 : tbarHeight,
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
                            onDelete: () => showOnDeleteDialog(context, bloc),
                          ),
                        ),
                      ),
                      CalendarioScreenHeader(
                        year: bloc.state.year,
                        month: bloc.state.month,
                        onMonthAdd: () => addMonth(context, bloc),
                        onMonthDec: () => decMonth(context, bloc),
                        onYearChanged: bloc.setYear,
                        onMonthChanged: bloc.setMonth,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () => bloc.load(resync: true),
                          child: ListView(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            children: [
                              CalendarPage(
                                diferenciais:
                                    bloc.state.currentEmprego.diferenciaisList,
                                page: bloc.state.getCalendarPage(),
                                onCalendarItemTap: (h, d) async {
                                  showHorasBts(
                                    context: context,
                                    bloc: bloc,
                                    selectedHora: h,
                                    data: d,
                                    isEdit: h != null,
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 4,
                                  bottom: 8,
                                ),
                                child: CalendarActions(),
                              ),
                              HorasList(
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
