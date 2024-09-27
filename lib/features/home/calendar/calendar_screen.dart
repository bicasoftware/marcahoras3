import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/features/home/calendar/calendario_screen_header.dart';
import 'package:marcahoras3/features/home/calendar/widgets/calendar_date_navigator.dart';
import 'package:marcahoras3/features/home/calendar/widgets/empregos_dropdown.dart';
import 'package:marcahoras3/features/home/horas_list/horas_list.dart';
import 'package:marcahoras3/features/home/widgets/add_hora_bts.dart';
import 'package:marcahoras3/features/home/widgets/popup_session.dart';
import 'package:marcahoras3/resources.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../widgets.dart';
import '../../../widgets/bottomsheets/bottomsheethelper.dart';
import 'calendar_page.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final strings = context.strings();

    return Scaffold(
      appBar: ShAppBar(
        label: strings.calendario,
        elevation: 0,
        roundedCorner: false,
        centerTitle: false,
        actions: [
          EmpregosDropdown(),
          PopupSessionButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'plus_button',
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.onSecondary,
        onPressed: () {
          BottomSheetHelper.showModalBts(
            context: context,
            dismissible: true,
            body: const AddHoraBts(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CalendarioScreenHeader(
              empregos: bloc.state.empregos,
              empregoPos: bloc.state.empregoPos,
              year: bloc.state.year,
              month: bloc.state.month,
              // onEmpregoChanged: (value) => bloc.setEmpregoPos(value),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CalendarPage(
                emprego: bloc.state.currentEmprego,
              ),
            ),
            const HorasList(horas: []),
          ],
        ),
      ),
    );
  }
}
