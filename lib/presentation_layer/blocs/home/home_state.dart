// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import '../../../domain_layer/models.dart';
import '../../../utils/utils.dart';

class HomeState extends BaseState {
  final int navigatorPos;
  final int empregoPos;
  final UnmodifiableListView<Empregos> empregos;
  final bool isDarkMode;
  final int month;
  final int year;

  HomeState({
    required super.status,
    this.empregoPos = -1,
    Iterable<Empregos> empregos = const [],
    this.navigatorPos = 0,
    this.isDarkMode = false,
    required this.year,
    required this.month,
  }) : empregos = UnmodifiableListView(empregos);

  HomeState copyWith({
    StateStatus? status,
    int? navigatorPos,
    Iterable<Empregos>? empregos,
    int? empregoPos,
    bool? isDarkMode,
    int? year,
    int? month,
  }) {
    return HomeState(
      status: status ?? this.status,
      navigatorPos: navigatorPos ?? this.navigatorPos,
      empregos: empregos ?? this.empregos,
      empregoPos: empregoPos ?? this.empregoPos,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      year: year ?? this.year,
      month: month ?? this.month,
    );
  }

  Empregos? get currentEmprego =>
      empregoPos == -1 ? null : empregos[empregoPos];

  @override
  String toString() {
    return 'HomeState(tabPos: $navigatorPos, empregoPos: $empregoPos, empregos: $empregos, isDarkMode: $isDarkMode)';
  }

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return other.navigatorPos == navigatorPos &&
        other.empregoPos == empregoPos &&
        other.empregos == empregos &&
        other.isDarkMode == isDarkMode;
  }

  @override
  int get hashCode {
    return navigatorPos.hashCode ^
        empregoPos.hashCode ^
        empregos.hashCode ^
        isDarkMode.hashCode;
  }
}
