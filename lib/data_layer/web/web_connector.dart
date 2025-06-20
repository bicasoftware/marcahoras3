import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../utils.dart';
import '../providers.dart';
import '../respositories.dart';
import 'interceptors/auth_interceptor.dart';
import 'web.dart';

class WebConnector {
  final JsonDecoder jsonDecoder;
  final Dio http;

  WebConnector([String? baseUrl])
    : jsonDecoder = const JsonDecoder(),
      http = Dio(
        BaseOptions(baseUrl: baseUrl ?? dotenv.get('base_url')),
      ) {
    http.interceptors.addAll([
      AuthInterceptor(
        dio: http,
        provider: RegistrationRepository(
          provider: RegistrationProvider(connector: this),
        ),
      ),
      // AwesomeDioInterceptor(
      // logRequestHeaders: true,
      // logResponseHeaders: true,
      // ),
    ]);
  }

  void addInterceptor(Interceptor i) => http.interceptors.add(i);

  bool removeInterceptor(Interceptor i) => http.interceptors.remove(i);

  Options buildOptions({
    String? token,
    WebMethod method = WebMethod.get,
    ResponseType responseType = ResponseType.json,
    ContentType? contentType,
    bool skipAuthentication = false,
  }) {
    return Options(
      headers: skipAuthentication ? null : {"Authorization": "Bearer $token"},
      method: method.name,
      contentType: (contentType ?? ContentType.json).mimeType,
      responseType: responseType,
    );
  }

  Future<WebResponse> request(
    String path, {
    WebMethod method = WebMethod.get,
    Object? data,
    JsonObj? queryParams,
    ResponseType responseType = ResponseType.json,
    bool skipAuth = false,
  }) async {
    final jsonData = await jsonDecoder.encode(data ?? {});
    final completePath = "/$path";
    try {
      final response = await http.request(
        completePath,
        data: jsonData,
        queryParameters: {
          ...(queryParams ?? {}),
        },
        options: buildOptions(
          token: Vault().token,
          method: method,
          responseType: responseType,
          skipAuthentication: skipAuth,
        ),
      );

      return _buildResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw WebException(
          error: 'Connection Error',
          message: 'Failed to access the server, try again later',
          code: 404,
        );
      }

      if (e.type == DioExceptionType.unknown) {
        throw e.error!;
      }

      throw WebException(
        error: e.response?.data['error'] ?? '',
        message: e.response?.data['message'] ?? '',
        code: e.response?.data['statusCode'] ?? 404,
      );
    }
  }

  Future<WebResponse> _buildResponse(Response? response) async {
    Object? data;
    if (response?.data != null) {
      response?.data is String
          ? data = await jsonDecoder.decode(response?.data)
          : data = response?.data;
    }

    return WebResponse(
      data: data,
      code: response?.statusCode ?? 500,
      message: response?.statusMessage ?? '',
    );
  }
}
