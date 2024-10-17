import 'package:equatable/equatable.dart';

import 'web_exception.dart';

/// Class that holds a HTTPRequest response data
class WebResponse extends Equatable {
  /// Http response status code
  /// {default as 404}
  final int statusCode;

  /// If the response was successful
  /// {default as false}
  final bool isSuccess;

  /// The response status message
  /// {defaults as ''}
  final String statusMessage;

  /// The payload data
  /// {default as null}
  final dynamic data;

  const WebResponse({
    this.statusCode = 404,
    this.statusMessage = '',
    this.data,
  }) : isSuccess = statusCode == 200 || statusCode == 201;

  @override
  List<Object?> get props => [
        statusCode,
        isSuccess,
        statusMessage,
        data,
      ];

  WebException toWebException() {
    return WebException(
      statusCode: statusCode,
      errorMessage: statusMessage,
    );
  }
}
