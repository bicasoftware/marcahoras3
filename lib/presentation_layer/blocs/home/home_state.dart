import 'package:marcahoras3/utils/bloc/state_status.dart';

import '../../../domain_layer/models.dart';
import '../../../utils/bloc/base_state.dart';

class HomeState extends BaseState {
  final List<Empregos> empregos;

  const HomeState({
    this.empregos = const [],
    required super.status,
  });

  @override
  List<Object?> get props => [
        empregos,
      ];

  HomeState copyWith({
    List<Empregos>? empregos,
    StateStatus? status,
  }) {
    return HomeState(
      empregos: empregos ?? this.empregos,
      status: status ?? this.status,
    );
  }
}
