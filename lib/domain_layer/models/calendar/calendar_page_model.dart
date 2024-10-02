import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../../models.dart';

class CalendarPageModel extends Equatable {
  final int month;
  final int year;
  final UnmodifiableListView<CalendarItemModel> items;
  final UnmodifiableListView<Horas> horas;

  CalendarPageModel({
    required this.month,
    required this.year,
    Iterable<CalendarItemModel> items = const [],
    Iterable<Horas> horas = const [],
  })  : items = UnmodifiableListView(items),
        horas = UnmodifiableListView(horas);

  @override
  List<Object> get props => [month, year, items];
}
