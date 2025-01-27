import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs.dart';
import '../../resources.dart';
import '../../utils/pdf_generator.dart';
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
    final strings = context.strings();
    final bloc = context.watch<HomeBloc>();
    final locale = Localizations.localeOf(context);
    final reportModel = bloc.state.currentReport();
    final String vigencia =
        "${strings.months[bloc.state.month]} de ${bloc.state.year}";

    return Scaffold(
      appBar: ShAppBar(
        label: strings.calendario,
        elevation: 0,
        roundedCorner: true,
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TotalsContainer(
          report: reportModel,
        ),
      ),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RelatorioHorasList(
          horas: reportModel.hours,
        ),
      ),
    );
  }
}
