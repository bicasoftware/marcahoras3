// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import '../../../domain_layer/models.dart';
import '../../../utils/utils.dart';

class HomeState extends BaseState {
  final int tabPos;
  final int? empregoPos;
  final UnmodifiableListView<Empregos> empregos;
  final bool isDarkMode;

  HomeState({
    required super.status,
    int? empregoPos,
    Iterable<Empregos> empregos = const [],
    this.tabPos = 0,
    this.isDarkMode = false,
  })  : empregos = UnmodifiableListView(empregos),
        empregoPos = empregos.isNotEmpty ? 0 : null;

  HomeState copyWith({
    StateStatus? status,
    int? tabPos,
    Iterable<Empregos>? empregos,
    int? empregoPos,
    bool? isDarkMode,
  }) {
    return HomeState(
      status: status ?? this.status,
      tabPos: tabPos ?? this.tabPos,
      empregos: empregos ?? this.empregos,
      empregoPos: empregoPos ?? this.empregoPos,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  Empregos? get currentEmprego =>
      empregoPos != null ? empregos[empregoPos!] : null;

  @override
  String toString() {
    return 'HomeState(tabPos: $tabPos, empregoPos: $empregoPos, empregos: $empregos, isDarkMode: $isDarkMode)';
  }

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;
  
    return 
      other.tabPos == tabPos &&
      other.empregoPos == empregoPos &&
      other.empregos == empregos &&
      other.isDarkMode == isDarkMode;
  }

  @override
  int get hashCode {
    return tabPos.hashCode ^
      empregoPos.hashCode ^
      empregos.hashCode ^
      isDarkMode.hashCode;
  }
}
