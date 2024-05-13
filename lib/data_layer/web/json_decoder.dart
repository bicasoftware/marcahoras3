import 'dart:convert';

class JsonDecoder {
  const JsonDecoder();

  Future<dynamic> decode(String source) async {
    return jsonDecode(source);
  }

  Future<String> encode(Object? data) async {
    return jsonEncode(data);
  }
}
