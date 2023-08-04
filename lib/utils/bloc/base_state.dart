import 'package:equatable/equatable.dart';
import 'package:marcahoras3/utils/bloc/state_status.dart';

class BaseState extends Equatable {
  final StateStatus status;

  const BaseState({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}
