import 'dart:typed_data';

import 'package:pdf/widgets.dart';

import '../domain_layer/models.dart';

class PdfGenerator {
  static Future<Uint8List> generate(List<Horas> horas) async {
    final pdf = Document();

    pdf.addPage(
      Page(
        build: (Context context) {
          return Column(
            children: [
              Text("Teste"),
              Text("Teste 2"),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
