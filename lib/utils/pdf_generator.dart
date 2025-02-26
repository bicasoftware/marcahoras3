import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../domain_layer/models.dart';
import '../utils.dart';

class PdfGenerator {
  static Future<Uint8List> generate({
    required String title,
    required ReportModel report,
    required Locale locale,
  }) async {
    final pdf = Document(
      theme: ThemeData.withFont(
        base: Font.ttf(await rootBundle.load("assets/fonts/Outfit-Medium.ttf")),
        bold: Font.ttf(await rootBundle.load("assets/fonts/Outfit-Bold.ttf")),
      ),
    );

    pdf.addPage(
      Page(
        margin: EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 16),
        build: (Context context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Table(
                border: TableBorder.all(color: PdfColors.black),
                children: [
                  TableRow(
                    children: [
                      TableHeaderText(text: 'Data'),
                      TableHeaderText(text: 'Inicio'),
                      TableHeaderText(text: 'Termino'),
                      TableHeaderText(text: 'Horas Feitas'),
                      TableHeaderText(text: '%'),
                      TableHeaderText(text: 'Total'),
                    ],
                  ),
                  ...report.hours
                      .map((h) => _horaRowDisplay(h, locale))
                      .toList(),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  Row(
                    children: [
                      _totaisDisplay(
                        "Normais: ${report.horasFeitasNormal}",
                        "Total - ${report.valorRecNormal}",
                      ),
                      _totaisDisplay(
                        "Normais: ${report.horasFeitasDiff}",
                        "Total - ${report.valorRecDiff}",
                      ),
                      _totaisDisplay(
                        "Total no Mês: ${report.horasFeitasTotal}",
                        "Total - ${report.valorRecDiff}",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}

Widget _totaisDisplay(String valor1, String valor2) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [TableText(text: valor1), TableText(text: valor2)],
    ),
  );
}

TableRow _horaRowDisplay(ReportHora h, Locale locale) {
  return TableRow(
    children: [
      TableText(text: formatDateByLocale(h.date, locale)),
      TableText(text: h.from),
      TableText(text: h.to),
      TableText(text: h.workedHours),
      TableText(text: "${h.porc}%"),
      TableText(text: h.amount),
    ],
  );
}

Widget TableText({
  required String text,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  TextStyle? style,
}) {
  return Padding(
    padding: padding,
    child: Text(
      text,
      style: style ?? TextStyle(color: PdfColors.black, fontSize: 14),
    ),
  );
}

Widget TableHeaderText({
  required String text,
  EdgeInsets padding = const EdgeInsets.all(8),
}) {
  return TableText(
    text: text,
    padding: const EdgeInsets.all(8),
    style: TextStyle(
      color: PdfColors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  );
}
