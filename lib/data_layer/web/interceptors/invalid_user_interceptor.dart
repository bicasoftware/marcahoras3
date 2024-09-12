import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/data_layer/web/web_exception.dart';
import 'package:marcahoras3/main.dart';
import 'package:marcahoras3/presentation_layer/blocs.dart';
import 'package:marcahoras3/realm/realm_connector.dart';
import 'package:marcahoras3/widgets.dart';

import '../../../routes.dart';
import '../../../routes_dta.dart';
import '../../../utils/utils.dart';

class InvalidUserInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      print("Erro de resposta: 401 - Não autorizado.");
      _doLogoff(err);
    } else if (err.response?.statusCode == 403) {
      throw err;
    } else if (![200, 201].contains(err.response?.statusCode)) {
      throw WebException(
        statusCode: err.response?.statusCode ?? 0,
        errorMessage: err.response?.statusMessage ?? '',
        errorDetail: err.response?.data['message'] ??
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

    /// Clean Realm data
    final r = RealmConnector();
    r.cleanAll();

    /// Delete data from the [Vault]
    final vaultManager = VaultManager();
    vaultManager.cleanAll();

    /// Call clean() method on [HomeBloc] which empties its state
    final blocHome = context.read<HomeBloc>();
    blocHome.clean();

    /// Call reset() method on [EmpregosDetailBloc] which cleans any temp data in it;
    final blocEmprego = context.read<EmpregosDetailBloc>();
    blocEmprego.reset();

    /// TODO - implementar possíveis coisas que precisem ser limpadas

    navigatorKey.currentState?.pushReplacementNamed(
      Routes.login,
      arguments: LoggedOffUserArgs(true),
    );
  }
}
