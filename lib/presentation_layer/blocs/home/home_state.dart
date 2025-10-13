import 'package:collection/collection.dart';

import '../../../domain_layer/models.dart';
import '../../../utils.dart';

class HomeState extends BaseState {
  final int empregoPos;
  final UnmodifiableListView<Empregos> empregos;
  final bool isDarkMode;
  final int month;
  final int year;
  final CalendarPageModel calendarPage;
  final ReportModel reportPage;

  HomeState({
    required this.year,
    required this.month,
    this.empregoPos = 0,
    Iterable<Empregos> empregos = const [],
    this.isDarkMode = false,
    required this.calendarPage,
    required this.reportPage,
    required super.status,
  }) : empregos = UnmodifiableListView(empregos);

  HomeState copyWith({
    StateStatus? status,
    Iterable<Empregos>? empregos,
    int? empregoPos,
    bool? isDarkMode,
    int? year,
    int? month,
    CalendarPageModel? calendarPage,
    ReportModel? reportPage,
  }) {
    final newState = HomeState(
      status: status ?? this.status,
      empregos: empregos ?? this.empregos,
      empregoPos: empregoPos ?? this.empregoPos,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      year: year ?? this.year,
      month: month ?? this.month,
      calendarPage: calendarPage ?? this.calendarPage,
      reportPage: reportPage ?? this.reportPage,
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
        other.isDarkMode == isDarkMode &&
        other.month == month &&
        other.year == year;
  }

  @override
  int get hashCode {
    return empregoPos.hashCode ^
        empregos.hashCode ^
        isDarkMode.hashCode ^
        month.hashCode ^
        year.hashCode;
  }
}
