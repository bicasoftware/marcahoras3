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
        appBar: AppConfig.shared.flavor != Flavor.desktop
            ? ShAppBar(
                label: Localiza.find('relatorios'),
                elevation: 0,
                roundedCorner: true,
                centerTitle: true,
              )
            : null,
        bottomNavigationBar: TotalsContainer(report: reportModel),
        floatingActionButton: _isMobile()
            ? FloatingActionButton(
                onPressed: () {
                  showPdfPreview(
                    context: context,
                    locale: locale,
                    vigencia: vigencia,
                    reportModel: reportModel,
                  );
                },
                child: Icon(Icons.picture_as_pdf, color: AppColors.onSecondary),
                backgroundColor: AppColors.secondary,
              )
            : null,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isMobile()) ...[
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12, top: 16),
                child: Text(
                  vigencia,
                  style: theme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant,
                    fontSize: 18,
                  ),
                ),
              ),
              const Divider(indent: 12, endIndent: 12),
            ],
            Expanded(
              child: RelatorioHorasList(
                horas: reportModel.hours,
                bancoHoras: reportModel.bancoHoras,
                diferenciais: diferenciais,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
