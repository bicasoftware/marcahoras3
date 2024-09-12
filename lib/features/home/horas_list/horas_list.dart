import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources/localizations/strings_data.dart';
import '../../../widgets/card_container.dart';
import '../../horas/horas_detail.dart';

class HorasList extends StatelessWidget {
  final List<Horas> horas;

  const HorasList({
    required this.horas,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return CardContainer(
      trailing: TextButton(
        child: Text(strings.horas),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HorasDetail(),
            ),
          );
        },
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (int i = 0; i < 6; i++) ListTile(title: Text('Hora $i'))
        ],
      ),
    );
  }
}
