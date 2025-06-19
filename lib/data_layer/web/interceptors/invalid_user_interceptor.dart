import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/data_layer/web/web_exception.dart';
import 'package:marcahoras3/main.dart';
import 'package:marcahoras3/presentation_layer/blocs.dart';
import 'package:marcahoras3/widgets.dart';

import '../../../routes.dart';
import '../../../routes_dta.dart';
import '../../../utils.dart';

class InvalidUserInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _doLogoff(err);
    } else if (err.response?.statusCode == 403) {
      throw err;
    } else if (![200, 201].contains(err.response?.statusCode)) {
      throw WebException(
        code: err.response?.statusCode ?? 0,
        message: err.response?.statusMessage ?? '',
        error: err.response?.data['message'] ??
            ['Erro de comunicação com servidor'],
      );
    }

    return handler.reject(err);
  }

  void _doLogoff(DioException err) {
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

    /// TODO - implementar possíveis coisas que precisem ser limpadas

    navigatorKey.currentState?.pushReplacementNamed(
      Routes.login,
      arguments: LoggedOffUserArgs(true),
    );
  }
}
