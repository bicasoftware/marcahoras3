import '../../../utils/utils.dart';

class RegistrationState extends BaseState {
  RegistrationState({
    required super.status,
  });

  RegistrationState copyWith({
    StateStatus? status,
  }) {
    return RegistrationState(status: status ?? this.status);
  }
}
