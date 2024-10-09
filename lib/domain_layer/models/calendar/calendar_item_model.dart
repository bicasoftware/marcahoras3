import 'package:equatable/equatable.dart';

import '../../models.dart';

sealed class CalendarItemModel {
  final Horas? horas;
  final DateTime? date;
  final bool? isToday;

  CalendarItemModel({required this.horas, required this.date, required this.isToday});
}

class CalendarItemEmpty extends CalendarItemModel {
  CalendarItemEmpty() : super(date: null, horas: null, isToday: false);
}

class CalendarItemDateOnly extends CalendarItemModel {
  CalendarItemDateOnly(DateTime data, bool isToday) : super(date: data, horas: null, isToday: isToday);
}

class CalendarItemComplete extends CalendarItemModel implements Equatable {
  CalendarItemComplete({
    required Horas horas,
    required DateTime date,
    required bool isToday,
  }) : super(horas: horas, date: date, isToday: isToday);

  @override
  List<Object?> get props => [horas, date];

  @override
  bool get stringify => true;

  HorasType get horaType => horas?.tipoHora ?? HorasType.unknown;

  int get horaColor => horaType.colorHex;

  int get weekDay => horas?.data.weekday ?? -1;
}
