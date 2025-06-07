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
    final weekdays = Localiza.findList('fullWeekDays');

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
              Divider(),
              if (report.normais.amount > 0 && report.normais.amount > 0)
                ReportSession(
                  diferenciadas: false,
                  tipo: Localiza.find("normais"),
                  porc: report.normais.porc,
                  amount: report.normais.getAmount(),
                  workedHours: report.normais.getWorkedHours(),
                  hours: report.hours
                      .where((h) => h.hora.tipoHora == HorasType.normal)
                      .toList(),
                ),
              if (report.feriados.amount > 0 && report.feriados.amount > 0)
                ReportSession(
                  diferenciadas: false,
                  tipo: Localiza.find("feriados"),
                  porc: report.feriados.porc,
                  amount: report.feriados.getAmount(),
                  workedHours: report.feriados.getWorkedHours(),
                  hours: report.hours
                      .where((h) => h.hora.tipoHora == HorasType.feriado)
                      .toList(),
                ),
              ...report.diferenciadas.map((d) {
                return ReportSession(
                  diferenciadas: true,
                  tipo: weekdays[d.weekday],
                  porc: d.porc,
                  workedHours: d.getWorkedHours(),
                  amount: d.getAmount(),
                  hours: report.hours.where(
                    (h) {
                      return h.hora.tipoHora == HorasType.diferencial &&
                          h.hora.data.weekday == d.weekday;
                    },
                  ).toList(),
                );
              }).toList(),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  ReportFooter(
                    tempo: report.total.getWorkedHours(),
                    valor: report.total.getAmount(),
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

Widget ReportHeader({
  required String date,
}) {
  return Text(
    Localiza.findAndReplace(
      stringKey: 'reportHeader',
      findString: '{DATA}',
      replaceWithKey: date,
    ),
    style: TextStyle(
      color: PdfColors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget ReportItemHeader({
  required String horaType,
  required String porc,
  required bool diferenciadas,
}) {
  return Container(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      Localiza.find(
        diferenciadas ? 'reportItemHeaderDif' : 'reportItemHeader',
      ).replaceAll('{TIPO}', horaType).replaceAll('{PORC}', porc),
      style: TextStyle(
        color: PdfColors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget ReportItem({
  required String data,
  required String inicio,
  required String fim,
  required String tempo,
  required String valor,
}) {
  return Text(
    Localiza.find(
          'reportItem',
        )
        .replaceAll('{DATA}', data)
        .replaceAll('{HORA_INICIO}', inicio)
        .replaceAll('{HORA_FIM}', fim)
        .replaceAll('{HORAS}', tempo)
        .replaceAll('{VALOR}', valor),
    style: TextStyle(color: PdfColors.black, fontSize: 12),
  );
}

Widget ReportSemiTotal({
  required String tempo,
  required String valor,
}) {
  return Container(
    padding: EdgeInsets.only(
      top: 8,
    ),
    child: Text(
      Localiza.find(
        'reportSemiTotal',
      ).replaceAll('{HORAS}', tempo).replaceAll('{VALOR}', valor),
      style: TextStyle(
        color: PdfColors.black,
        fontSize: 14,
        fontItalic: Font.timesItalic(),
      ),
    ),
  );
}

Widget ReportFooter({
  required String tempo,
  required String valor,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        Localiza.find(
          'reportFooterTempo',
        ).replaceAll('{HORAS}', tempo),
        style: TextStyle(color: PdfColors.black, fontSize: 14),
      ),
      Text(
        Localiza.find(
          'reportFooterValor',
        ).replaceAll('{VALOR}', valor),
        style: TextStyle(color: PdfColors.black, fontSize: 14),
      ),
    ],
  );
}

Widget ReportSession({
  required String tipo,
  required int porc,
  required String workedHours,
  required String amount,
  required List<ReportHora> hours,
  required bool diferenciadas,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ReportItemHeader(
        horaType: tipo,
        porc: "$porc%",
        diferenciadas: diferenciadas,
      ),
      ...hours.map(
        (h) => ReportItem(
          data: h.getDate(),
          inicio: h.from,
          fim: h.to,
          tempo: h.workedHours,
          valor: h.amount,
        ),
      ),
      ReportSemiTotal(
        tempo: workedHours,
        valor: amount,
      ),
      Divider(),
    ],
  );
}
