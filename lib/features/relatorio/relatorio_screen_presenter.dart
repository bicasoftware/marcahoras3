import 'package:flutter/material.dart';

import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs.dart';
import '../../utils.dart';
import 'pdf_preview_screen.dart';

mixin RelatorioScreenPresenter {
  String formatPDFVigencia(HomeBloc bloc, Locale locale) {
    return formatVigencia(
      bloc.state.year,
      bloc.state.month,
      locale,
      'MMMM/yyyy',
    ).toCamelCase();
  }

  void showPdfPreview({
    required BuildContext context,
    required ReportModel reportModel,
    required String vigencia,
    required Locale locale,
  }) async {
    final data = await PdfGenerator.generate(
      report: reportModel,
      title: Localiza.findAndReplace(
        stringKey: 'reportHeader',
        findString: '{DATA}',
        replaceWithKey: vigencia,
      ),
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
}
