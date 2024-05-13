import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String baseUrl = "localhost:3000";
  FlutterConfig.loadValueForTesting({"base_url": baseUrl});

  test('should read a value from json .env file', () {
    assert(baseUrl == FlutterConfig.get('base_url'));
  });
}
