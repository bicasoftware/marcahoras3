import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import '../../models.dart';

class CalendarPageModel extends Equatable {
  final int month;
  final int year;
  final UnmodifiableListView<CalendarItemModel> items;
  final UnmodifiableListView<Horas> horas;
  final UnmodifiableListView<Horas> _horasDetail;

  CalendarPageModel({
    required this.month,
    required this.year,
    Iterable<CalendarItemModel> items = const [],
    Iterable<Horas> horas = const [],
  })  : items = UnmodifiableListView(items),
        horas = UnmodifiableListView(horas),
        _horasDetail = UnmodifiableListView(
          horas.sorted((a, b) => a.data.compareTo(b.data)).take(5).toList(),
        );

  @override
  List<Object> get props => [month, year, items, horas];

  CalendarPageModel copyWith({
    Iterable<CalendarItemModel>? items,
    Iterable<Horas>? horas,
  }) {
    return CalendarPageModel(
      month: this.month,
      year: this.year,
      items: items ?? this.items,
      horas: horas ?? this.horas,
    );
  }

  List<Horas> get horasList => _horasDetail;
}
