import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs.dart';
import '../../resources.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'pdf_preview_screen.dart';
import 'widgets/relatorio_horas_list.dart';
import 'widgets/relatorio_totalizer.dart';

class RelatorioScreen extends StatelessWidget {
  const RelatorioScreen({super.key});

  void _showPdfPreview({
    required BuildContext context,
    required ReportModel reportModel,
    required String vigencia,
    required Locale locale,
  }) async {
    final data = await PdfGenerator.generate(
      report: reportModel,
      title: "Relatório de Horas de $vigencia",
      locale: locale,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return PdfPreviewScreen(
            title: "PDF - Prévia",
            pdfData: data,
            fileName:
                "horas_${vigencia.replaceAll(' ', '_').toLowerCase()}.pdf",
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final theme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);
    final reportModel = bloc.state.getReportPage();
    final String vigencia =
        formatVigencia(
          bloc.state.year,
          bloc.state.month,
          locale,
          'MMMM/yyyy',
        ).toCamelCase();

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: ShAppBar(
          label: Localiza.find('relatorios'),
          elevation: 0,
          roundedCorner: true,
          centerTitle: true,
        ),
        bottomNavigationBar: TotalsContainer(report: reportModel),
        floatingActionButton: FloatingActionButton(
          heroTag: "plus_button",
          onPressed: () {
            _showPdfPreview(
              context: context,
              locale: locale,
              vigencia: vigencia,
              reportModel: reportModel,
            );
          },
          child: Icon(Icons.picture_as_pdf, color: AppColors.onSecondary),
          backgroundColor: AppColors.secondary,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12, top: 16),
              child: Text(
                vigencia,
                style: theme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurfaceVariant,
                  fontSize: 18,
                ),
              ),
            ),
            const Divider(indent: 12, endIndent: 12),
            Expanded(child: RelatorioHorasList(horas: reportModel.hours)),
          ],
        ),
      ),
    );
  }
}
