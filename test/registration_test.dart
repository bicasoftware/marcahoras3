import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/repositories/registration_repository.dart';
import 'package:marcahoras3/data_layer/web.dart';
import 'package:marcahoras3/domain_layer/usecases.dart';

void main() {
  final connector = WebConnector("http://localhost:3000");
  connector.addInterceptor(InvalidUserInterceptor());
  connector.addInterceptor(AwesomeDioInterceptor(
    logRequestHeaders: true,
    logResponseHeaders: true,
  ));
  final String email = "test@test.com";
  final String password = "123456";
  final String wrongPassword = "1234banana";

  final provider = RegistrationProvider(connector: connector);
  final repository = RegistrationRepository(provider: provider);
  final loginUseCase = LoginUserUsecase(repo: repository);

  test('should return accessToken from provider', () async {
    try {
      final result = await provider.login(email: email, password: password);
      print(result.accessToken);

      assert(result.accessToken != '');
    } on WebException catch (e) {
      print(e.errorDetail);
      print(e.errorMessage);
    } on DioException catch (e) {
      print('erro doidera ${e}');
    }
  });

  test('should fail retrieving token from provider', () async {
    try {
      final result = await provider.login(
        email: email,
        password: wrongPassword,
      );
      print(result.accessToken);
    } on WebException catch (e) {
      assert(e.errorMessage != '');
    }
  });

  test('should return token from repository', () async {
    try {
      final result = await provider.login(email: email, password: password);
      print(result.accessToken);

      assert(result.accessToken != '');
    } on WebException catch (e) {
      print(e.errorDetail);
      print(e.errorMessage);
    } on DioException catch (e) {
      print('erro doidera ${e}');
    }
  });
  test('should fail to return token from repository', () async {
    try {
      final result = await provider.login(
        email: email,
        password: wrongPassword,
      );
      print(result.accessToken);
    } on WebException catch (e) {
      assert(e.errorMessage != '');
    }
  });

  test('should return token from usecase', () async {
    try {
      final result = await loginUseCase(email: email, password: password);
      print(result.accessToken);
      assert(result.accessToken != '');
    } on WebException catch (e) {
      assert(e.errorMessage != '');
    }
  });
  test('should fail to return token from usecase', () async {
    try {
      final result = await loginUseCase(email: email, password: wrongPassword);
      assert(result.accessToken != '');
    } on WebException catch (e) {
      assert(e.errorMessage != '');
    }
  });
}
