import 'package:dio/dio.dart';
import 'package:synchronized/synchronized.dart';

import '../../../utils.dart';
import '../../respositories.dart';
import '../web_utils/logoff_helper.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Dio _dio;
  final Lock _lock = Lock();
  final RegistrationRepository _authRepo;

  AuthInterceptor({
    required Dio dio,
    required RegistrationRepository provider,
  }) : _dio = dio,
       _authRepo = provider;

  final String AUTH_HEADER = 'Authorization';

  String get _tokenHeaderString => "Bearer ${Vault().token}";

  bool _isSameAuthHeader(DioException err) {
    return err.requestOptions.headers[AUTH_HEADER] == _tokenHeaderString;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await _lock.synchronized(() async {
          /// Se o Authorization header é diferente, continua a request
          if (!_isSameAuthHeader(err)) {
            return handler.resolve(
              await _dio.fetch(
                err.requestOptions..headers[AUTH_HEADER] = _tokenHeaderString,
              ),
            );
          }

          /// Authorization header é igual, então pede novas tokens
          final refreshed = await _authRepo.refresh();

          /// Se houver falha para pegar as novas tokens, efetua logoff do usuário
          if (!refreshed) {
            LogoffHelper.handleLogoff(err);
          }

          /// Com as novas tokens já no [Vault], atualiza o Authorization header
          /// e reenvia a request
          err.requestOptions.headers[AUTH_HEADER] = _tokenHeaderString;
          return handler.resolve(await _dio.fetch(err.requestOptions));
        });
      } catch (_) {
        return handler.next(err);
      }
    }

    return handler.next(err);
  }
}
