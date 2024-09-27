import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/features/empregos/empregos/empregos_screen.dart';
import 'package:marcahoras3/features/home/calendar/calendar_screen.dart';
import 'package:marcahoras3/resources/localizations/strings_data.dart';

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
      body: bloc.state.navigatorPos == 0
          ? const EmpregosScreen()
          : const CalendarScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: state.navigatorPos,
        onTap: bloc.setNavigationbarPosition,
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
