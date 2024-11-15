import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/features/relatorio/pdf_preview_screen.dart';
import 'package:marcahoras3/features/relatorio/totalizer.dart';

import '../../presentation_layer/blocs.dart';
import '../../resources.dart';
import '../../utils/pdf_generator.dart';
import '../../widgets.dart';
import 'widgets/relatorio_horas_list.dart';
import 'widgets/relatorio_totalizer.dart';

class RelatorioScreen extends StatefulWidget {
  const RelatorioScreen({
    super.key,
  });

  @override
  State<RelatorioScreen> createState() => _RelatorioScreenState();
}

class _RelatorioScreenState extends State<RelatorioScreen> {
  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final bloc = context.watch<HomeBloc>();
    final locale = Localizations.localeOf(context);
    final reportModel = bloc.state.currentReport();

    final totalizer = ReportTotalizer(
      salario: bloc.state.currentEmprego!.getSalarioByVigencia(
        bloc.state.year,
        bloc.state.month,
      ),
      cargaHoraria: bloc.state.currentEmprego!.cargaHoraria,
      porcNormal: bloc.state.currentEmprego!.porcNormal,
      porcFeriado: bloc.state.currentEmprego!.porcFeriado,
      page: bloc.state.currentPage(),
    );

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
                title:
                    "Relatório de Horas de ${strings.months[bloc.state.month]} de ${bloc.state.year}",
                horas: bloc.state.currentPage().horas,
                totais: totalizer,
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
          totais: totalizer,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            RelatorioHorasList(
              label: strings.horaNormal,
              horas: bloc.state.currentPage().horas,
              onDelete: (_) {},
              emprego: bloc.state.currentEmprego!,
              onItemTap: (_) {},
            ),

            ///Totalizadores
          ],
        ),
      ),
    );
  }
}
