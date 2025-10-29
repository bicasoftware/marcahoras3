import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../resources.dart';
import '../../../routes.dart';
import '../../../utils.dart';
import '../../../widgets.dart';
import 'calendar_screen_presenter.dart';

class CalendarActions extends StatelessWidget
    with CalendarScreenPresenterMixin {
  const CalendarActions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final bloc = context.read<HomeBloc>();

    return DualActionButton(
      firstColor: AppColors.surface,
      secondColor: AppColors.surface,
      firstLabel: Text(
        Localiza.find("relatorios"),
        style: theme.bodyMedium!.copyWith(
          color: bloc.state.hasReportData()
              ? AppColors.onSecondary
              : AppColors.disabled,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      secondLabel: Text(
        Localiza.find("horasExtras"),
        style: theme.bodyMedium!.copyWith(
          color: AppColors.onSecondary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      firstIcon: Icon(
        Icons.list,
        color: bloc.state.hasReportData()
            ? AppColors.onSecondary
            : AppColors.disabled,
      ),
      secondIcon: Icon(Icons.add, color: AppColors.onSecondary),
      onFirstTap: () {
        if (bloc.state.hasReportData()) {
          Navigator.of(context).pushNamed(Routes.relatorio);
        }
      },
      onSecondTap: () => showHorasBts(context: context, bloc: bloc),
    );
  }
}
