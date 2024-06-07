import 'package:flutter/material.dart';
import 'package:marcahoras3/features/horas/horas_detail.dart';
import 'package:marcahoras3/presentation_layer/resources/localizations/strings_data.dart';
import 'package:marcahoras3/widgets/card_container.dart';

import '../../../domain_layer/models.dart';

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
      extrasButtonText: strings.verTodas,
      onExtraTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HorasDetail(),
          ),
        );
      },
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
