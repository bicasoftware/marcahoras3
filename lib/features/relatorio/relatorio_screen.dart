import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/app_config.dart';
import 'package:marcahoras3/features/relatorio/relatorio_screen_presenter.dart';

import '../../presentation_layer/blocs.dart';
import '../../resources.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'widgets/relatorio_horas_list.dart';
import 'widgets/relatorio_totalizer.dart';

class RelatorioScreen extends StatelessWidget with RelatorioScreenPresenter {
  const RelatorioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final theme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);
    final reportModel = bloc.state.getReportPage();
    final diferenciais = bloc.state.currentEmprego.diferenciaisList;

    final String vigencia = formatPDFVigencia(bloc, locale);

    bool _isMobile() {
      return AppConfig.shared.flavor != Flavor.desktop;
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: ShAppBar(
          label: Localiza.find('relatorios'),
          elevation: 0,
          roundedCorner: true,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.print_outlined),
              onPressed: () {
                showPdfPreview(
                  context: context,
                  locale: locale,
                  vigencia: vigencia,
                  reportModel: reportModel,
                );
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 12, right: 12, top: 16),
              color: AppColors.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    vigencia,
                    textAlign: TextAlign.start,
                    style: theme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                      fontSize: 18,
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
            Expanded(
              child: RelatorioHorasList(
                horas: reportModel.hours,
                bancoHoras: reportModel.bancoHoras,
                diferenciais: diferenciais,
              ),
            ),
            TotalsContainer(report: reportModel),
          ],
        ),
      ),
    );
  }
}
