import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:marcahoras3/utils/utils.dart';

import 'web.dart';

class WebConnector {
  final JsonDecoder jsonDecoder;
  final Dio http;

  WebConnector()
      : jsonDecoder = const JsonDecoder(),
        http = Dio(
          BaseOptions(
            baseUrl: FlutterConfig.get('base_url'),
          ),
        );

  void addInterceptor(Interceptor i) => http.interceptors.add(i);

  bool removeInterceptor(Interceptor i) => http.interceptors.remove(i);

  Options buildOptions({
    String? token,
    String? authHeader,
    WebMethod method = WebMethod.get,
    ResponseType responseType = ResponseType.json,
    ContentType? contentType,
  }) {
    return Options(
      headers: {
        if (authHeader != null) "Authorization": authHeader,
        if (authHeader != null && token != null)
          "Authorization": "Bearer $token"
      },
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
    String? authHeader,
    ResponseType responseType = ResponseType.plain,
  }) async {
    final jsonData = await jsonDecoder.encode(data);
    final completePath = "/$path";
    try {
      final response = await http.request(
        completePath,
        data: jsonData,
        queryParameters: {
          if (queryParams != null) ...queryParams,
        },
        options: buildOptions(
          authHeader: authHeader,
          method: method,
          responseType: responseType,
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
          WebException(
            errorMessage: e.message.toString(),
            statusCode: e.response?.statusCode ?? 500,
          );
      }

      if (e.response != null) {
        return _buildResponse(e.response);
      }

      rethrow;
    }
  }

  Future<WebResponse> _buildResponse(Response? response) async {
    final decodedData = await jsonDecoder.decode(response?.data ?? '');

    return WebResponse(
      data: decodedData,
      statusCode: response?.statusCode ?? 500,
      statusMessage: response?.statusMessage ?? '',
    );
  }
}
