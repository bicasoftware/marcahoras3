import 'dart:collection';

import '../../../domain_layer/models.dart';
import '../../../utils/utils.dart';

class HomeState extends BaseState {
  final UnmodifiableListView<Empregos> empregos;
  final Empregos? selectedEmprego;

  HomeState({
    required super.status,
    Iterable<Empregos> empregos = const [],
    this.selectedEmprego,
  }) : empregos = UnmodifiableListView(empregos);

  @override
  List<Object?> get props => [
        status,
        empregos,
        selectedEmprego,
      ];

  HomeState copyWith({
    List<Empregos>? empregos,
    StateStatus? status,
    Empregos? selectedEmprego,
  }) {
    return HomeState(
      empregos: empregos ?? this.empregos,
      status: status ?? this.status,
      selectedEmprego: selectedEmprego ?? this.selectedEmprego,
    );
  }

  int get empregoLength => empregos.length;
}
