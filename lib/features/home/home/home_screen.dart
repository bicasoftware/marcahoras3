import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain_layer/models.dart';
import '../../../presentation_layer/blocs.dart';
import '../../../presentation_layer/route_args.dart';
import '../../../routes.dart';
import '../../../screens.dart';
import '../../../widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> showCreateScreen(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      Routes.empregosDetail,
      arguments: EmpregosArguments(Empregos.empty(), true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();

    return BlocHelper<HomeBloc, HomeState>(
      bloc: bloc,
      hasData: (s) => s.empregos.isEmpty,
      showErrorWidget: true,
      errorWidget: (err) => ShDefaultErrorScaffold(
        errorMsg: err.errorMsg,
        onRetry: () => bloc.load(resync: true),
      ),
      noDataChild: Scaffold(
        body: NoDataContainer(
          labelId: "empregosVazio",
          extraLabelId: "empregosVazioExtra",
          helperButtonTap: () => showCreateScreen(context),
        ),
      ),
      child: CalendarScreen(),
    );
  }
}
