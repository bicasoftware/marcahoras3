// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import '../../../domain_layer/models.dart';
import '../../../utils/utils.dart';

class HomeState extends BaseState {
  final int tabPos;
  final int? empregoPos;
  final UnmodifiableListView<Empregos> empregos;

  HomeState({
    required super.status,
    int? empregoPos,
    Iterable<Empregos> empregos = const [],
    this.tabPos = 0,
  })  : empregos = UnmodifiableListView(empregos),
        empregoPos = empregos.isNotEmpty ? 0 : null;

  HomeState copyWith({
    StateStatus? status,
    int? tabPos,
    Iterable<Empregos>? empregos,
    int? empregoPos,
  }) {
    return HomeState(
      status: status ?? this.status,
      tabPos: tabPos ?? this.tabPos,
      empregos: empregos ?? this.empregos,
      empregoPos: empregoPos ?? this.empregoPos,
    );
  }

  Empregos? get currentEmprego => empregoPos != null ? empregos[empregoPos!] : null;

  @override
  String toString() =>
      'HomeState(tabPos: $tabPos, currentEmprego: $currentEmprego, empregos: $empregos)';

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return other.tabPos == tabPos &&
        other.currentEmprego == currentEmprego &&
        other.empregos == empregos;
  }

  @override
  int get hashCode =>
      tabPos.hashCode ^
      currentEmprego.hashCode ^
      empregos.hashCode ^
      status.hashCode;
}
