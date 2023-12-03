import 'package:marcahoras3/utils/bloc/base_state.dart';

sealed class StateStatus {}

class StateSuccessStatus<T extends BaseState> extends StateStatus {
  StateSuccessStatus({required this.state});

  final T state;
}

class StateErrorStatus<T extends BaseState> extends StateStatus {
  String errorMsg;

  StateErrorStatus({required this.errorMsg});
}

class StateLoadingStatus extends StateStatus {}
