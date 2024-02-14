import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';

class CalendarContent extends StatelessWidget {
  final Empregos emprego;

  const CalendarContent({required this.emprego, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(emprego.descricao),
    );
  }
}
