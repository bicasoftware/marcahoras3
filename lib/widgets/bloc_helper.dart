import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/utils.dart';
import 'package:marcahoras3/widgets.dart';

class BlocHelper<B extends StateStreamable<S>, S extends BaseState>
    extends StatelessWidget {
  final B bloc;
  final Widget child;

  final ValueChanged<String>? onError;
  final Widget? noDataChild;
  final bool Function(S state)? hasData;

  final Widget Function(StateErrorStatus err)? errorWidget;
  final bool showErrorWidget;

  BlocHelper({
    required this.child,
    required this.bloc,
    this.onError,
    this.hasData,
    this.noDataChild,
    this.errorWidget,
    this.showErrorWidget = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      bloc: bloc,
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state.status is StateErrorStatus) {
          if(!showErrorWidget) {
            if (onError != null) {
              onError!((state.status as StateErrorStatus).errorMsg);
            } else {
              context.showFloatingMessage(
                (state.status as StateErrorStatus).errorMsg,
                MessageType.error,
              );
          }
          }
        }
      },
      child: _getChild(),
    );
  }

  Widget _getChild() {
    if (bloc.state.status is StateLoadingStatus) {
      return LoadingScreen(child: child);
    }

    if(bloc.state.status is StateErrorStatus && errorWidget != null) {
      return errorWidget!(bloc.state.status as StateErrorStatus);
    }

    if (hasData != null && noDataChild != null) {
      if (hasData!(bloc.state)) {
        return noDataChild!;
      }
    }

    return child;
  }
}
