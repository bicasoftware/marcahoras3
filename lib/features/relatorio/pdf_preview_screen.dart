import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../widgets.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String title;
  final Uint8List pdfData;

  const PdfPreviewScreen({
    required this.title,
    required this.pdfData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShAppBar(label: title),
      body: PdfPreview(
        build: (_) => pdfData,
      ),
    );
  }
}
