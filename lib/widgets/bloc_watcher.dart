import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/utils/utils.dart';

import '../widgets.dart';

class BlocWatcher<B extends StateStreamable<S>, S extends BaseState>
    extends StatelessWidget {
  final Widget Function(BuildContext c, S state) builder;
  final Widget? onError;
  final Widget? onLoading;

  const BlocWatcher({
    required this.builder,
    this.onError,
    this.onLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(builder: (BuildContext context, S state) {
      switch (state.status) {
        case StateSuccessStatus _:
          return builder(context, state);
        case StateLoadingStatus _:
          return onLoading ?? const LoadingWidget();
        case StateErrorStatus _:
          return onError ?? Text((state.status as StateErrorStatus).errorMsg);
      }
    });
  }
}
