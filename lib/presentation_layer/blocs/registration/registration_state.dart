import 'package:flutter/foundation.dart';

import '../../../utils.dart';

@immutable
class RegistrationState extends BaseState {
  final String errorMsg;

  const RegistrationState({
    required this.errorMsg,
    required super.status,
  });

  RegistrationState copyWith({
    String? errorMsg,
    StateStatus? status,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  bool operator ==(covariant RegistrationState other) {
    if (identical(this, other)) return true;

    return other.errorMsg == errorMsg && other.status == this.status;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
