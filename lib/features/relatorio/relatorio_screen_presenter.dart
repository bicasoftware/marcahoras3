import 'package:flutter/material.dart';

import '../../domain_layer/models.dart';
import '../../presentation_layer/blocs.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'pdf_preview_screen.dart';
import 'totals_bts/report_totals_bts.dart';

mixin RelatorioScreenPresenter {
  String formatPDFVigencia(HomeBloc bloc, Locale locale) {
    return formatVigencia(
      bloc.state.year,
      bloc.state.month,
      locale,
      'MMMM/yyyy',
    ).toCamelCase();
  }

  String formatFechamento(DateTime ini, DateTime end, Locale locale) {
    return "De: ${formatDateByLocale(ini, locale)} - ${formatDateByLocale(end, locale)}";
  }

  void showTotalsBts({
    required BuildContext context,
    required ReportModel report,
    required String vigencia,
  }) async {
    final locale = Localizations.localeOf(context);
    final showPDFScreen = await BottomSheetHelper.showModalBts(
      context: context,
      dismissible: true,
      leading: Container(
        margin: EdgeInsets.only(right: 12),
        child: Icon(Icons.calendar_month),
      ),
      title: Localiza.find('totais'),
      trailing: IconButton(
        icon: Icon(
          Icons.close,
        ),
        onPressed: () {
          Navigator.of(context).pop(); // Close the current bts
        },
      ),
      body: ReportTotalsBts(
        report: report,
        onPrintTap: () => showPdfPreview(
          context: context,
          reportModel: report,
          vigencia: vigencia,
          locale: locale,
        ),
      ),
    );

    if (showPDFScreen == true) {
      showPdfPreview(
        context: context,
        locale: context.locale,
        vigencia: vigencia,
        reportModel: report,
      );
    }
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
