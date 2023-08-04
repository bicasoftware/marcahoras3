import 'package:flutter/widgets.dart';
import 'package:marcahoras3/utils/bloc/state_status.dart';
import 'package:marcahoras3/widgets.dart';

import '../utils/bloc/base_state.dart';

class StateListener<T extends BaseState> extends StatelessWidget {
  final T state;
  final Widget Function(T state) onSuccess;

  const StateListener({
    required this.state,
    required this.onSuccess,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case LoadingStatus _:
        return const LoadingWidget();
      case SuccessStatus _:
        return onSuccess(state);
      case ErrorStatus _:
        return Text((state.status as ErrorStatus).errorMsg);
    }
  }
}
