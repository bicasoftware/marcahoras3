import 'dart:collection';

import '../../../domain_layer/models.dart';
import '../../../utils/utils.dart';

class HomeState extends BaseState {
  final UnmodifiableListView<Empregos> empregos;
  final Empregos? selectedEmprego;
  final int tabPos;

  HomeState({
    required super.status,
    Vault? vault,
    Iterable<Empregos> empregos = const [],
    this.tabPos = 0,
    this.selectedEmprego,
  }) : empregos = UnmodifiableListView(empregos);

  @override
  List<Object?> get props => [
        status,
        empregos,
        selectedEmprego,
        tabPos,
      ];

  HomeState copyWith({
    List<Empregos>? empregos,
    StateStatus? status,
    Empregos? selectedEmprego,
    Vault? vault,
    int? tabPos,
  }) {
    return HomeState(
      empregos: empregos ?? this.empregos,
      status: status ?? this.status,
      selectedEmprego: selectedEmprego ?? this.selectedEmprego,
      tabPos: tabPos ?? this.tabPos,
    );
  }

  int get empregoLength => empregos.length;
}
