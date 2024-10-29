import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/features/relatorio/widgets/relatorio_totalizer.dart';
import 'package:marcahoras3/resources.dart';

import '../../presentation_layer/blocs.dart';
import '../../widgets.dart';
import 'widgets/relatorio_horas_list.dart';

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

    return Scaffold(
      appBar: ShAppBar(
        label: strings.calendario,
        elevation: 0,
        roundedCorner: false,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save_alt),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RelatorioTotalizer(
          salario: bloc.state.currentEmprego!.getSalarioByVigencia(
            bloc.state.year,
            bloc.state.month,
          ),
          cargaHoraria: bloc.state.currentEmprego!.cargaHoraria,
          porcNormal: bloc.state.currentEmprego!.porcNormal,
          porcFeriado: bloc.state.currentEmprego!.porcFeriado,
          page: bloc.state.currentPage(),
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
