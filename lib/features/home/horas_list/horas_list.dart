import 'package:flutter/material.dart';
import 'package:marcahoras3/features/horas/horas_detail.dart';
import 'package:marcahoras3/widgets/card_container.dart';

import '../../../domain_layer/models.dart';
import '../../../strings.dart';

class HorasList extends StatelessWidget {
  final List<Horas> horas;

  const HorasList({
    required this.horas,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      extrasButtonText: Strings.verTodas,
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
