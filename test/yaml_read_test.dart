import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/utils.dart';
import 'package:yaml/yaml.dart';

void main() {
  final yamlString = """
novo:
  pt_BR: Novo
  en_US: New
months:
  pt_BR:
    - Janeiro
    - Fevereiro
    - Março
    - Abril
    - Maio
    - Junho
    - Julho
    - Agosto
    - Setembro
    - Outubro
    - Novembro
    - Dezembro
  en_US:
    - January
    - February
    - March
    - April
    - May
    - June
    - July
    - August
    - September
    - Ouctober
    - November
    - December
""";

  test('should load a yaml file', () async {
    final parsedY = loadYaml(yamlString);
    Localiza().init(parsedY, "en_US");
  });

  test('should read a string from a loaded yaml file', () {
    final parsedY = loadYaml(yamlString);
    Localiza().init(parsedY, "en_US");

    final string = Localiza.find('novo');
    assert(string == "New");
  });

  test('should read a list of strings from a loaded yaml file', () {
    final parsedY = loadYaml(yamlString);
    Localiza().init(parsedY, "pt_BR");

    final meses = Localiza.findList('months');
    print(meses);
  });
}
