import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../routes.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import 'calendar_screen_presenter.dart';

class CalendarActions extends StatelessWidget
    with CalendarScreenPresenterMixin {
  const CalendarActions({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final bloc = context.read<HomeBloc>();

    return DualActionButton(
      firstColor: colors.surface,
      secondColor: colors.surface,
      firstLabel: Text(
        Localiza.find("relatorios"),
        style: textTheme.bodyMedium!.copyWith(
          color: bloc.state.hasReportData()
              ? colors.onSecondary
              : colors.outline,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      secondLabel: Text(
        Localiza.find("horasExtras"),
        style: textTheme.bodyMedium!.copyWith(
          color: colors.onSecondary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      firstIcon: Icon(
        Icons.list,
        color: bloc.state.hasReportData() ? colors.onSecondary : colors.outline,
      ),
      secondIcon: Icon(Icons.add, color: colors.onSecondary),
      onFirstTap: () {
        if (bloc.state.hasReportData()) {
          Navigator.of(context).pushNamed(Routes.relatorio);
        }
      },
      onSecondTap: () => showHorasBts(context: context, bloc: bloc),
    );
  }
}
