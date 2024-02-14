import 'package:marcahoras3/utils/bloc/base_state.dart';

sealed class StateStatus {}

class StateSuccessStatus extends StateStatus {
  StateSuccessStatus();
}

class StateErrorStatus<T extends BaseState> extends StateStatus {
  String errorMsg;

  StateErrorStatus({required this.errorMsg});
}

class StateLoadingStatus extends StateStatus {}
