import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/features/empregos/empregos_screen.dart';
import 'package:marcahoras3/features/home/home_content.dart';
import 'package:marcahoras3/presentation_layer/blocs/home/home_state.dart';
import 'package:marcahoras3/presentation_layer/resources/localizations/strings_data.dart';
import 'package:marcahoras3/widgets/bloc_watcher.dart';
import 'package:marcahoras3/widgets/hr_appbar.dart';

import '../../presentation_layer/blocs/home/home_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final bloc = context.watch<HomeBloc>();
    final state = bloc.state;

    return Scaffold(
      appBar: HrAppBar(label: context.strings().appName),
      body: BlocWatcher<HomeBloc, HomeState>(
        builder: (c, HomeState state) {
          return state.tabPos == 0
              ? const EmpregosScreen()
              : const HomeContent();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: state.tabPos,
        onTap: bloc.setTabPos,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: strings.empregos,
            icon: const Icon(Icons.work_outline),
          ),
          BottomNavigationBarItem(
            label: strings.horas,
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}
