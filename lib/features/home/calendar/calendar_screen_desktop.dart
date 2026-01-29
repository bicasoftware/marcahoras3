import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import '../../relatorio/relatorio_screen.dart';
import '../../relatorio/relatorio_screen_presenter.dart';
import 'calendar_page.dart';
import 'calendar_screen_presenter.dart';
import 'calendario_screen_header.dart';
import 'widgets/empregos_dropdown.dart';

class CalendarScreenDesktop extends StatefulWidget {
  const CalendarScreenDesktop({super.key});

  @override
  State<CalendarScreenDesktop> createState() => _CalendarScreenDesktopState();
}

class _CalendarScreenDesktopState extends State<CalendarScreenDesktop>
    with CalendarScreenPresenterMixin, RelatorioScreenPresenter {
  double dragStartPoint = 0.0;
  final int swipeDistance = 60;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final bloc = context.watch<HomeBloc>();
    final tbarHeight = MediaQuery.of(context).viewPadding.top;
    final locale = Localizations.localeOf(context);

    if (bloc.state.empregos.isEmpty) {
      return Scaffold(
        body: Center(
          child: NoDataContainer(
            contentLabel: Localiza.find("empregosEmpty"),
            helperButtonLabel: Localiza.find("adicionarEmprego"),
            helperButtonTap: () => showEmpregosScreen(
              context: context,
              bloc: bloc,
              isInsert: true,
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: tbarHeight == 0.0 ? 8.0 : tbarHeight,
                  color: colors.primary,
                ),
                Container(
                  color: colors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colors.surface,
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
                  yearList: bloc.state.getYears(),
                  onMonthAdd: () => addMonth(context, bloc),
                  onMonthDec: () => decMonth(context, bloc),
                  onYearChanged: bloc.setYear,
                  onMonthChanged: bloc.setMonth,
                ),
                const SizedBox(height: 8),
                CalendarPage(
                  diferenciais: bloc.state.currentEmprego.diferenciaisList,
                  page: bloc.state.getCalendarPage(),
                  onCalendarItemTap: (h, d, f) async {
                    showHorasBts(
                      context: context,
                      bloc: bloc,
                      selectedHora: h,
                      data: d,
                      isEdit: h != null,
                    );
                  },
                ),
                const Spacer(),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ShElevatedButton(
                          label: Localiza.find('gerarPDF'),
                          color: colors.primary,
                          iconColor: colors.onPrimary,
                          icon: Icons.picture_as_pdf,
                          onTap: () => showPdfPreview(
                            context: context,
                            reportModel: bloc.state.getReportPage(),
                            vigencia: formatPDFVigencia(bloc, locale),
                            locale: locale,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ShElevatedButton(
                          label: Localiza.find('novahora'),
                          color: colors.primary,
                          iconColor: colors.onPrimary,
                          icon: Icons.more_time_rounded,
                          onTap: () => showHorasBts(
                            context: context,
                            bloc: bloc,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ShElevatedButton(
                          label: Localiza.find('novoEmprego'),
                          color: colors.primary,
                          iconColor: colors.onPrimary,
                          icon: Icons.work,
                          onTap: () => showEmpregosScreen(
                            context: context,
                            bloc: bloc,
                            isInsert: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(child: RelatorioScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
