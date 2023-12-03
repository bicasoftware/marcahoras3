import 'package:flutter/widgets.dart';
import 'package:marcahoras3/utils/bloc/state_status.dart';
import 'package:marcahoras3/widgets.dart';

import '../utils/bloc/base_state.dart';

class StateListener<T extends BaseState> extends StatelessWidget {
  final T state;
  final Widget Function(T state) onSuccessView;
  final Widget? onLoadingView;
  final Widget? onErrorView;

  const StateListener({
    required this.state,
    required this.onSuccessView,
    this.onLoadingView,
    this.onErrorView,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case StateSuccessStatus _:
        return onSuccessView(state);
      case StateLoadingStatus _:
        return onLoadingView ?? const LoadingWidget();
      case StateErrorStatus _:
        return onErrorView ?? Text((state.status as StateErrorStatus).errorMsg);
    }
  }
}
