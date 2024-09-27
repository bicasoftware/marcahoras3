import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import 'calendar_header.dart';
import 'widgets/calendar_date_navigator.dart';

class CalendarioScreenHeader extends StatefulWidget {
  final List<Empregos> empregos;
  final int? empregoPos;
  final int month;
  final int year;

  const CalendarioScreenHeader({
    required this.empregos,
    required this.month,
    required this.year,
    this.empregoPos,
    super.key,
  });

  @override
  State<CalendarioScreenHeader> createState() => _CalendarioScreenHeaderState();
}

class _CalendarioScreenHeaderState extends State<CalendarioScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inversePrimary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CalendarDateNavigator(
            year: widget.year,
            month: widget.month,
          ),
          const CalendarHeader(),
        ],
      ),
    );
  }
}
