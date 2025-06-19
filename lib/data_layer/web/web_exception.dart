import '../../utils/extensions/json_helper.dart';

class WebException implements Exception {
  final String error;
  final String message;
  final int code;

  const WebException({
    this.message = '',
    this.error = '',
    this.code = 500,
  });

  static WebException? fromJson(Map<String, dynamic>? json) {
    return json != null
        ? WebException(
            error: json.nodeValueOrDefault('error', ''),
            message: json.nodeValueOrDefault('message', ''),
            code: json.nodeValueOrDefault('statusCode', 500),
          )
        : null;
  }

  @override
  String toString() =>
      'WebException(error: $error, message: $message, code: $code)';
}
