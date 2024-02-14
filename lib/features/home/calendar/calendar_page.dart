import 'package:flutter/material.dart';
import 'package:marcahoras3/features/home/calendar/calendar_item.dart';

import '../../../domain_layer/models.dart';
import '../../../presentation_layer/resources/colors.dart';
import '../../../presentation_layer/shared_widgets/bottomsheethelper.dart';
import '../../../widgets/card_container.dart';
import '../widgets/add_hora_bts.dart';
import 'calendar_header.dart';

class CalendarPage extends StatelessWidget {
  final Empregos emprego;

  const CalendarPage({
    required this.emprego,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CalendarHeader(),
            const SizedBox(height: 8),
            CardContainer(
              child: Column(
                children: [
                  // TODO - Mudar isso pra um próprio widget baseado no mês, mas num arquivo separado
                  GridView.count(
                    crossAxisCount: 7,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      for (int i = 0; i < 31; i++)
                        CalendarItem(
                          weekDay: 1,
                          type:
                              i % 2 == 0 ? HorasType.normal : HorasType.feriado,
                          monthDay: i + 1,
                        )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
        Positioned(
          right: 5,
          bottom: 0,
          child: FloatingActionButton.small(
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
        ),
      ],
    );
  }
}
