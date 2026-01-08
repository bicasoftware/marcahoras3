import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../utils.dart';
import '../../widgets.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String title;
  final Uint8List pdfData;
  final String fileName;

  const PdfPreviewScreen({
    required this.title,
    required this.pdfData,
    required this.fileName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShAppBar(label: title),
      body: PdfPreview(
        build: (_) => pdfData,
        allowPrinting: true,
        allowSharing: true,
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        pdfFileName: fileName,
        pdfPreviewPageDecoration: BoxDecoration(
          color: Colors.white,
        ),
        actionBarTheme: PdfActionBarTheme(
          backgroundColor: context.colors.secondary,
        ),
      ),
    );
  }
}
