import 'package:marcahoras3/utils/extensions/json_helper.dart';

class WebException implements Exception {
  /// The Exception error message
  /// {defaults as ''}
  String errorMessage;

  /// More information about the error
  /// {defaults as ''}
  String errorDetail;

  /// HTTP status code
  /// {defaults as 500}
  int statusCode;

  WebException({
    this.errorMessage = '',
    this.errorDetail = '',
    this.statusCode = 500,
  });

  @override
  bool operator ==(covariant WebException other) {
    if (identical(this, other)) return true;

    return other.errorMessage == errorMessage &&
        other.errorDetail == errorDetail &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode =>
      errorMessage.hashCode ^ errorDetail.hashCode ^ statusCode.hashCode;

  /// Transforms a json map into a [WebException]
  static WebException? fromJson(Map<String, dynamic>? json, int? code) {
    return json != null
        ? WebException(
            errorMessage: json.nodeValueOrDefault('message', ''),
            errorDetail: json.nodeValueOrDefault('error', ''),
            statusCode: json.nodeValueOrDefault('statusCode', 500),
          )
        : null;
  }

  @override
  String toString() =>
      'WebException(errorMessage: $errorMessage, errorDetail: $errorDetail, statusCode: $statusCode)';
}
