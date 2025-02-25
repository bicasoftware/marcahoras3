import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import '../../../utils.dart';
import '../../models.dart';

class CalendarPageModel extends Equatable {
  final int month;
  final int year;
  final UnmodifiableListView<CalendarItemModel> items;
  final UnmodifiableListView<Horas> horas, _normais, _feriados;

  CalendarPageModel({
    required this.month,
    required this.year,
    Iterable<CalendarItemModel> items = const [],
    Iterable<Horas> horas = const [],
  })  : items = UnmodifiableListView(items),
        horas = UnmodifiableListView(
          horas.sorted((a, b) => a.data.compareTo(b.data)),
        ),
        _normais = UnmodifiableListView(
          horas.where((h) => h.tipoHora == HorasType.normal),
        ),
        _feriados = UnmodifiableListView(
          horas.where((h) => h.tipoHora == HorasType.feriado),
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

  List<Horas> get horasList => horas.take(3).toList();

  List<Horas> listHorasByType(HorasType type) {
    return type == HorasType.normal ? _normais : _feriados;
  }

  (double, int) sumByHorasType({
    required HorasType type,
    required double salario,
    required int cargaHoraria,
    required int porc,
  }) {
    double valor = 0.0;
    int tempo = 0;

    listHorasByType(type).forEach((it) {
      valor += CalcHelper.calcValorReceber(
        salario: salario,
        from: it.inicio,
        to: it.termino,
        cargaHoraria: cargaHoraria,
        porcentagem: porc,
      );

      tempo += TimeOfDayHelper.getMinutesBetweenTimes(it.inicio, it.termino);
    });

    return (valor, tempo);
  }
}
