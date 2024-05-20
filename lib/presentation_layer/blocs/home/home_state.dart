import 'dart:collection';

import '../../../domain_layer/models.dart';
import '../../../utils/utils.dart';

class HomeState extends BaseState {
  final UnmodifiableListView<Empregos> empregos;
  final Empregos? selectedEmprego;
  final Vault? _vault;

  HomeState({
    required super.status,
    Vault? vault,
    Iterable<Empregos> empregos = const [],
    this.selectedEmprego,
  })  : empregos = UnmodifiableListView(empregos),
        _vault = vault;

  @override
  List<Object?> get props => [
        _vault,
        status,
        empregos,
        selectedEmprego,
      ];

  HomeState copyWith({
    List<Empregos>? empregos,
    StateStatus? status,
    Empregos? selectedEmprego,
    Vault? vault,
  }) {
    return HomeState(
      empregos: empregos ?? this.empregos,
      status: status ?? this.status,
      selectedEmprego: selectedEmprego ?? this.selectedEmprego,
      vault: vault ?? _vault,
    );
  }

  int get empregoLength => empregos.length;

  String get token => _vault?.token ?? '';
  bool get hasToken => token.isNotEmpty;

  String get refreshToken => _vault?.refreshToken ?? '';
  bool get hasRefreshToken => refreshToken.isNotEmpty;
}
