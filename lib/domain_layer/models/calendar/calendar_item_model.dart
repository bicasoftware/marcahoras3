import 'package:equatable/equatable.dart';

import '../../models.dart';

sealed class CalendarItemModel {
  final Horas? horas;
  final DateTime? date;

  CalendarItemModel({required this.horas, required this.date});
}

class CalendarItemEmpty extends CalendarItemModel {
  CalendarItemEmpty() : super(date: null, horas: null);
}

class CalendarItemDateOnly extends CalendarItemModel {
  CalendarItemDateOnly(DateTime data) : super(date: data, horas: null);
}

class CalendarItemComplete extends CalendarItemModel implements Equatable {
  CalendarItemComplete({
    Horas? horas,
    DateTime? date,
  }) : super(horas: null, date: null);

  @override
  List<Object?> get props => [horas, date];

  @override
  bool get stringify => true;

  HorasType get horaType => horas?.tipoHora ?? HorasType.unknown;

  int get horaColor => horaType.colorHex;

  int get weekDay => horas?.data.weekday ?? -1;
}
