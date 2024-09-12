import 'dart:io';

import 'package:dio/dio.dart';
import 'package:marcahoras3/utils/utils.dart';

import 'web.dart';

class WebConnector {
  final JsonDecoder jsonDecoder;
  final Dio http;

  String? _token;

  set token(String? token) => _token = token;

  String? get currentToken => _token;

  WebConnector([String? baseUrl])
      : jsonDecoder = const JsonDecoder(),
        http = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? const String.fromEnvironment('base_url'),
          ),
        );

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
      switch (e.type) {
        case DioExceptionType.cancel:
          return const WebResponse(
            statusCode: 204, // No Data return cause was cancelled,
            statusMessage: 'RequestCanceled',
          );

        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const WebResponse(
            statusCode: 500,
            statusMessage: 'Connectivity error',
          );

        default:
          return WebResponse(
            statusCode: e.response?.statusCode ?? 500,
            statusMessage: e.response?.data['message'] ?? '',
            data: e.response,
          );
      }
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
      statusCode: response?.statusCode ?? 500,
      statusMessage: response?.statusMessage ?? '',
    );
  }
}
