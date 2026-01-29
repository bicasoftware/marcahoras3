import 'package:collection/collection.dart';

import '../../../domain_layer/models.dart';
import '../../../utils.dart';

class HomeState extends BaseState {
  final int empregoPos, navPos;
  final UnmodifiableListView<Empregos> empregos;
  final bool isDarkMode;
  final int month;
  final int year;
  final CalendarPageModel calendarPage;
  final ReportModel reportPage;
  final UnmodifiableListView<Anos> anos;

  HomeState({
    required this.year,
    required this.month,
    this.empregoPos = 0,
    this.navPos = 1,
    Iterable<Empregos> empregos = const [],
    this.isDarkMode = false,
    required this.calendarPage,
    required this.reportPage,
    Iterable<Anos> anos = const [],
    required super.status,
  }) : empregos = UnmodifiableListView(empregos),
       anos = UnmodifiableListView(anos);

  HomeState copyWith({
    StateStatus? status,
    Iterable<Empregos>? empregos,
    int? empregoPos,
    int? navPos,
    bool? isDarkMode,
    int? year,
    int? month,
    CalendarPageModel? calendarPage,
    ReportModel? reportPage,
    List<Anos>? anos,
  }) {
    final newState = HomeState(
      status: status ?? this.status,
      empregos: empregos ?? this.empregos,
      empregoPos: empregoPos ?? this.empregoPos,
      navPos: navPos ?? this.navPos,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      year: year ?? this.year,
      month: month ?? this.month,
      calendarPage: calendarPage ?? this.calendarPage,
      reportPage: reportPage ?? this.reportPage,
      anos: anos ?? this.anos,
    );

    return newState;
  }

  Empregos get currentEmprego => empregos[empregoPos];

  ReportModel getReportPage() => reportPage;

  CalendarPageModel getCalendarPage() => calendarPage;

  bool hasReportData() => reportPage.hours.isNotEmpty;

  Salarios getSalarioByVigencia(int year, int month) {
    return currentEmprego.getSalarioByVigencia(year, month);
  }

  bool get bancoHoras {
    if (currentEmprego.salarios.isEmpty) return false;

    return currentEmprego.bancoHoras;
  }

  List<Feriados> getFeriados([int? searchYear]) {
    return anos
            .firstWhereOrNull((f) => f.ano == (searchYear ?? year))
            ?.feriados ??
        [];
  }

  List<int> getYears() {
    return anos.map((a) => a.ano).toList();
  }

  List<ReportHora> reportShortData() {
    final length = reportPage.hours.length;
    return length < 3
        ? reportPage.hours
        : reportPage.hours.slice(length - 3, length);
  }

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return other.empregoPos == empregoPos &&
        other.empregos == empregos &&
        other.navPos == navPos &&
        other.isDarkMode == isDarkMode &&
        other.month == month &&
        other.year == year;
  }

  @override
  int get hashCode {
    return empregoPos.hashCode ^
        empregos.hashCode ^
        navPos.hashCode ^
        isDarkMode.hashCode ^
        month.hashCode ^
        year.hashCode;
  }
}
