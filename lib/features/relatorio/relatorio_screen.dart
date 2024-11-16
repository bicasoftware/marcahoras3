import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation_layer/blocs.dart';
import '../../resources.dart';
import '../../utils/pdf_generator.dart';
import '../../widgets.dart';
import 'pdf_preview_screen.dart';
import 'widgets/relatorio_horas_list.dart';
import 'widgets/relatorio_totalizer.dart';

class RelatorioScreen extends StatelessWidget {
  const RelatorioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final bloc = context.watch<HomeBloc>();
    final locale = Localizations.localeOf(context);
    final reportModel = bloc.state.currentReport();
    
    return Scaffold(
      appBar: ShAppBar(
        label: strings.calendario,
        elevation: 0,
        roundedCorner: false,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async {
              final data = await PdfGenerator.generate(
                report: reportModel,
                title:
                    "Relatório de Horas de ${strings.months[bloc.state.month]} de ${bloc.state.year}",
                locale: locale,
              );

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return PdfPreviewScreen(
                      title: "Teste",
                      pdfData: data,
                    );
                  },
                ),
              );
            },
            icon: Icon(Icons.save_alt),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TotalsContainer(
          report: reportModel,
        ),
      ),
      body: RelatorioHorasList(
        horas: reportModel.hours,
      ),
    );
  }
}
