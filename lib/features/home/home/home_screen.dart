import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/features/empregos/empregos_list/empregos_list_screen.dart';
import 'package:marcahoras3/features/home/calendar/calendar_screen.dart';
import 'package:marcahoras3/features/relatorio/relatorio_screen.dart';
import 'package:marcahoras3/utils/localiza/localiza.dart';

import '../../../domain_layer/models.dart';
import '../../../presentation_layer/blocs.dart';
import '../../../presentation_layer/route_args.dart';
import '../../../resources.dart';
import '../../../routes.dart';
import '../../../utils/uuid_factory.dart';
import '../../../widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController controller;

  int pos = 0;

  @override
  void initState() {
    final pos = context.read<HomeBloc>().state.navPos;
    controller = TabController(
      length: 3,
      vsync: this,
      animationDuration: Duration(milliseconds: 300),
      initialIndex: pos,
    )..addListener(_onNavigate);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_onNavigate);
    controller.dispose();
    super.dispose();
  }

  void _onNavigate() {}

  Future<void> showCreateScreen(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      Routes.empregosDetail,
      arguments: EmpregosArguments(Empregos(id: UuidFactory.build()), true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
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
          contentLabel: Localiza.find("empregosEmpty"),
          helperButtonLabel: Localiza.find("adicionarEmprego"),
          helperButtonTap: () => showCreateScreen(context),
        ),
      ),
      child: bloc.state.empregos.isEmpty
          ? Scaffold(body: Container())
          : Scaffold(
              body: TabBarView(
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  EmpregosListScreen(),
                  CalendarScreen(),
                  RelatorioScreen(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: AppColors.secondary,
                selectedItemColor: AppColors.onSecondary,
                elevation: 0,
                currentIndex: bloc.state.navPos,
                onTap: (value) {
                  controller.animateTo(value);
                  bloc.setNavPos(value);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.work),
                    label: Localiza.find("empregos"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month),
                    label: Localiza.find("calendario"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt),
                    label: Localiza.find("relatorios"),
                  ),
                ],
              ),
            ),
    );
  }
}
