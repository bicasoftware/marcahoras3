import 'dart:convert';

class JsonDecoder {
  const JsonDecoder();

  Future<dynamic> decode(String source) async {
    if (source.isEmpty) return null;
    return jsonDecode(source);
  }

  Future<String> encode(Object? data) async {
    return jsonEncode(data);
  }
}
