import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/utils/utils.dart';
import 'package:marcahoras3/widgets.dart';

class BlocHelper<B extends StateStreamable<S>, S extends BaseState>
    extends StatelessWidget {
  final Widget child;
  final ValueChanged<String> onError;
  final B bloc;

  const BlocHelper({
    required this.child,
    required this.bloc,
    required this.onError,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      bloc: bloc,
      listenWhen: (previous, current) {
        return previous != current;
      },
      child: child,
      listener: (context, state) {
        switch (state.status) {
          case StateLoadingStatus():
            LoadingScreen(child: child);
          case StateErrorStatus<BaseState>(): 
            onError((state.status as StateErrorStatus).errorMsg);
          case StateSuccessStatus():
        }
      },
    );
  }
}
