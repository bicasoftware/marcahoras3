import 'package:marcahoras3/utils/bloc/base_state.dart';

sealed class StateStatus {}

class SuccessStatus<T extends BaseState> extends StateStatus {
  SuccessStatus({required this.state});

  final T state;
}

class ErrorStatus<T extends BaseState> extends StateStatus {
  String errorMsg;

  ErrorStatus({required this.errorMsg});
}

class LoadingStatus extends StateStatus {}
