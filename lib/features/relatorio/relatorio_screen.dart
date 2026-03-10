import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../presentation_layer/blocs.dart';
import '../../routes.dart';
import '../../screens.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'relatorio_horas_list.dart';

class RelatorioScreen extends StatelessWidget
    with RelatorioScreenPresenter, CalendarScreenPresenterMixin {
  const RelatorioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final reportModel = bloc.state.getReportPage();
    final diferenciais = bloc.state.currentEmprego.diferenciaisList;

    final String vigencia = formatPDFVigencia(bloc, context.locale);

    return ShScaffold(
      appBar: ShAppBar(
        label: Localiza.find('relatorios'),
        elevation: 0,
        roundedCorner: true,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'FAB',
        label: ShText('totais'),
        icon: Icon(FontAwesomeIcons.tableList),
        onPressed: () => showTotalsBts(
          context: context,
          report: reportModel,
          vigencia: vigencia,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: .symmetric(horizontal: 16),
            title: Text(vigencia),
            subtitle: Text(
              formatFechamento(
                reportModel.fechamento!.inicio,
                reportModel.fechamento!.termino,
                context.locale,
              ),
            ),
            leading: CircleAvatar(
              child: Icon(FontAwesomeIcons.listUl),
            ),
          ),
          Expanded(
            child: Hero(
              tag: Routes.relatorio,
              child: Material(
                child: RelatorioHorasList(
                  horas: reportModel.hours,
                  bancoHoras: reportModel.bancoHoras,
                  diferenciais: diferenciais,
                  onEdit: (h) {
                    showHorasBts(
                      context: context,
                      bloc: bloc,
                      isEdit: true,
                      selectedHora: h,
                      data: h.data,
                    );
                  },
                  onDelete: (h) {
                    deleteHora(context, h, bloc);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
