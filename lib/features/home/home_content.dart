import 'package:flutter/material.dart';

import '../../presentation_layer/blocs/home/home_bloc.dart';
import '../../presentation_layer/blocs/home/home_state.dart';
import '../../widgets/bloc_watcher.dart';
import 'calendar/calendar_page.dart';
import 'horas_list/horas_list.dart';
import 'widgets/emprego_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocWatcher<HomeBloc, HomeState>(
      builder: (c, s) {
        return Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              EmpregoCard(
                empregos: s.empregos,
                selectedEmprego: s.selectedEmprego!,
              ),
              const SizedBox(height: 8),
              CalendarPage(
                emprego: s.selectedEmprego!,
              ),
              const HorasList(horas: []),
            ],
          ),
        );
      },
    );
  }
}
