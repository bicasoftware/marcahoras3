import 'dart:collection';
import '../../../domain_layer/models.dart';
import '../../../utils/utils.dart';

class HomeState extends BaseState {
  final UnmodifiableListView<Empregos> empregos;

  HomeState({
    Iterable<Empregos> empregos = const [],
    required super.status,
  }) : empregos = UnmodifiableListView(empregos);

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
