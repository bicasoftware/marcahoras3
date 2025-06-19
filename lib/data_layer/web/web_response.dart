import 'package:equatable/equatable.dart';

import 'web_exception.dart';

/// Class that holds a HTTP Request response data
class WebResponse extends Equatable {
  final int code;
  final String message;
  final String error;
  final dynamic data;

  const WebResponse({
    this.code = 404,
    this.message = '',
    this.error = '',
    this.data,
  });

  bool get isSuccess => code == 200 || code == 201;

  @override
  List<Object?> get props => [
    code,
    isSuccess,
    message,
    error,
    this.data,
  ];

  WebException toWebException() {
    return WebException(
      code: code,
      message: message,
      error: error,      
    );
  }
}
