import 'package:yaml/yaml.dart';

class Localiza {
  Localiza._();

  static Localiza? _instance;
  static String _locale = '';

  static late YamlMap _parsedYaml;

  factory Localiza() {
    _instance ??= Localiza._();
    return _instance!;
  }

  void init(dynamic parsedYaml, String locale) {
    _parsedYaml = parsedYaml;
    _locale = locale;
  }

  static String find(String stringName) {
    return _parsedYaml.containsKey(stringName)
        ? _parsedYaml[stringName][_locale]
        : stringName;
  }

  static List<String> findList(String keyName) {
    return _parsedYaml.containsKey(keyName)
        ? (_parsedYaml[keyName][_locale] as YamlList)
            .map((e) => e.toString())
            .toList()
        : [keyName];
  }
}
