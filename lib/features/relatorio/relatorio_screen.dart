import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation_layer/blocs.dart';
import '../../screens.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'widgets/relatorio_horas_list.dart';
import 'widgets/relatorio_totalizer.dart';

class RelatorioScreen extends StatelessWidget
    with RelatorioScreenPresenter, CalendarScreenPresenterMixin {
  const RelatorioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final reportModel = bloc.state.getReportPage();
    final diferenciais = bloc.state.currentEmprego.diferenciaisList;

    final String vigencia = formatPDFVigencia(bloc, context.locale);

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: ShAppBar(
          label: Localiza.find('relatorios'),
          elevation: 0,
          roundedCorner: true,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.print_outlined),
              onPressed: () {
                showPdfPreview(
                  context: context,
                  locale: context.locale,
                  vigencia: vigencia,
                  reportModel: reportModel,
                );
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 12, right: 12, top: 16),
              color: context.colors.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    vigencia,
                    textAlign: TextAlign.start,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colors.onSurface,
                      fontSize: 18,
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
            Expanded(
              child: RelatorioHorasList(
                horas: reportModel.hours,
                bancoHoras: reportModel.bancoHoras,
                diferenciais: diferenciais,
                onEdit: (h) {
                  showHorasBts(
                    context: context,
                    bloc: bloc,
                    isEdit: true,
                    selectedHora: h,
                    data: h.data,
                  );
                },
                onDelete: (h) {
                  deleteHora(context, h, bloc);
                },
              ),
            ),
            TotalsContainer(report: reportModel),
          ],
        ),
      ),
    );
  }
}
