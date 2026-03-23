import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../presentation_layer/blocs.dart';
import '../../routes.dart';
import '../../screens.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'relatorio_horas_list.dart';

class RelatorioScreen extends StatefulWidget {
  const RelatorioScreen({super.key});

  @override
  State<RelatorioScreen> createState() => _RelatorioScreenState();
}

class _RelatorioScreenState extends State<RelatorioScreen>
    with RelatorioScreenPresenter, CalendarScreenPresenterMixin {
  bool _isNavigating = false;
  final double swipeDistance = 60.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final bloc = context.watch<HomeBloc>();
    final reportModel = bloc.state.getReportPage();
    final diferenciais = bloc.state.currentEmprego.diferenciaisList;

    final String vigencia = formatPDFVigencia(bloc, context.locale);

    return ShScaffold(
      appBar: ShAppBar(label: 'relatorio'),
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
          Padding(
            padding: const .symmetric(horizontal: 16),
            child: ShLabeledListSection(
              formatFechamento(
                reportModel.fechamento!.inicio,
                reportModel.fechamento!.termino,
                context.locale,
              ),
              style: textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.normal,
                fontStyle: .italic,
                color: colors.primary,
              ),
            ),
          ),
          Divider(
            indent: 16,
            endIndent: 16,
            color: colors.primaryFixed,
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification) {
                  if (!_isNavigating &&
                      notification.metrics.pixels < -swipeDistance) {
                    setState(() => _isNavigating = true);
                    Navigator.of(context).pop();
                  }
                }
                return false;
              },
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
          ),
        ],
      ),
    );
  }
}
