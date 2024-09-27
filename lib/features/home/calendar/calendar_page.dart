import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../widgets/card_container.dart';
import 'calendar_item.dart';

class CalendarPage extends StatelessWidget {
  final Empregos? emprego;

  const CalendarPage({
    this.emprego,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
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
                    type: i % 2 == 0 ? HorasType.normal : HorasType.feriado,
                    monthDay: i + 1,
                  )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
