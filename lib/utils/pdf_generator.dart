import 'dart:typed_data';
import 'dart:ui';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../domain_layer/models.dart';
import '../features/relatorio/totalizer.dart';
import 'utils.dart';

///TODO - Gerar no state a lista de horas 

class PdfGenerator {
  static Future<Uint8List> generate({
    required String title,
    required List<Horas> horas,
    required ReportTotalizer totais,
    required Locale locale,
  }) async {
    final pdf = Document();

    pdf.addPage(
      Page(
        build: (Context context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                      TableHeaderText(text: 'Total'),
                    ],
                  ),
                  ...horas.map((h) => _horaRowDisplay(h, locale)).toList()
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
                        "Normais: ${totais.horasNormalFeitasFmt}",
                        "Total - ${totais.horasNormaisReceberFmt}",
                      ),
                      _totaisDisplay(
                        "Normais: ${totais.horasFeriadoFeitasFmt}",
                        "Total - ${totais.horasFeriadosReceberFmt}",
                      ),
                      _totaisDisplay(
                          "Total no Mês: ${totais.horasFeitasTotalFmt}",
                          "Total - ${totais.horasReceberTotalFmt}"),
                    ],
                  )
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
      children: [
        TableText(text: valor1),
        TableText(text: valor2),
      ],
    ),
  );
}

TableRow _horaRowDisplay(Horas h, Locale locale) {
// 'Data'
// 'Inicio'
// 'Termino'
// 'Horas Feitas'
// 'Total'

  return TableRow(
    children: [
      TableText(text: formatDateByLocale(h.data, locale)),
      TableText(text: h.inicio.asString()),
      TableText(text: h.termino.asString()),
      TableText(
          text: TimeOfDayHelper.getTimeOfDayInRange(h.inicio, h.termino)
              .asString()),
      TableText(text: CurrencyHelper.formatAmount(0.0)),
    ],
  );
}

Widget TableText({
  required String text,
  EdgeInsets padding = const EdgeInsets.symmetric(
    horizontal: 8,
    vertical: 4,
  ),
  TextStyle? style,
}) {
  return Padding(
    padding: padding,
    child: Text(
      text,
      style: style,
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
    ),
  );
}
