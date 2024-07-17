import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/utils/utils.dart';

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
      listener: (context, state) {
        if (state.status is StateErrorStatus) {
          onError((state.status as StateErrorStatus).errorMsg);
        }
      },
      child: child,
    );
  }
}
