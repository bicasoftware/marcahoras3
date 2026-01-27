import 'package:equatable/equatable.dart';

import '../../../resources.dart';
import '../../models.dart';

sealed class CalendarItemModel {
  final Horas? horas;
  final DateTime? date;
  final bool? isToday;
  final Feriados? feriado;
  final bool enabled;

  CalendarItemModel({
    required this.horas,
    required this.date,
    required this.isToday,
    this.enabled = true,
    this.feriado,
  });
}

class CalendarItemDisabled extends CalendarItemModel {
  CalendarItemDisabled(DateTime data, bool isToday)
    : super(date: data, horas: null, isToday: isToday, enabled: false);
}

class CalendarItemEmpty extends CalendarItemModel {
  CalendarItemEmpty() : super(date: null, horas: null, isToday: false);
}

class CalendarItemDateOnly extends CalendarItemModel {
  CalendarItemDateOnly(DateTime data, bool isToday, [Feriados? feriado])
    : super(date: data, horas: null, isToday: isToday, feriado: feriado);
}

class CalendarItemBancoHoras extends CalendarItemModel implements Equatable {
  CalendarItemBancoHoras({
    required Horas horas,
    required DateTime date,
    required bool isToday,
    Feriados? feriado,
  }) : super(horas: horas, date: date, isToday: isToday, feriado: feriado);

  HorasType get horaType => horas?.tipoHora ?? HorasType.unknown;

  int get horaColor => ExtraColors.porcNormalColor.toARGB32();

  int get weekDay => horas?.data.weekday ?? -1;

  @override
  List<Object?> get props => [horas, date, isToday];

  @override
  bool? get stringify => true;
}

class CalendarItemComplete extends CalendarItemModel implements Equatable {
  CalendarItemComplete({
    required Horas horas,
    required DateTime date,
    required bool isToday,
    Feriados? feriado,
  }) : super(horas: horas, date: date, isToday: isToday, feriado: feriado);

  @override
  List<Object?> get props => [horas, date];

  @override
  bool get stringify => true;

  HorasType get horaType => horas?.tipoHora ?? HorasType.unknown;

  int get horaColor => horaType.colorHex;

  int get weekDay => horas?.data.weekday ?? -1;
}
