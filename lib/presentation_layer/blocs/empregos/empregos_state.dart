import 'dart:collection';

import '../../../domain_layer/models.dart';
import '../../../utils/utils.dart';

class EmpregosState extends BaseState {
  final UnmodifiableListView<Empregos> empregos;

  EmpregosState({
    required super.status,
    Iterable<Empregos> empregos = const [],
  }) : empregos = UnmodifiableListView(empregos);

  EmpregosState copyWith({
    Iterable<Empregos>? empregos,
    StateStatus? status,
  }) {
    return EmpregosState(
      empregos: empregos ?? this.empregos,
      status: status ?? this.status,
    );
  }
}
