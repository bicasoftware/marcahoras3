import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/widgets.dart';

import '../../../presentation_layer/blocs.dart';
import '../../../routes.dart';
import '../../../routes_dta.dart';
import '../../../utils.dart';

class LogoffHelper {
  static void handleLogoff(DioException err) {
    final context = navigatorKey.currentState?.context;

    showErrorDialog(
      context: context!,
      errorMsg:
          err.message ?? 'Erro de comunicação com servidor. Desconectando...',
    );

    /// Delete data from the [Vault]
    final vaultManager = VaultManager();
    vaultManager.cleanAll();

    /// Call clean() method on [HomeBloc] which empties its state
    final blocHome = context.read<HomeBloc>();
    blocHome.clean();

    navigatorKey.currentState?.pushReplacementNamed(
      Routes.login,
      arguments: LoggedOffUserArgs(true),
    );
  }
}
