import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/data_layer/providers.dart';
import 'package:marcahoras3/data_layer/respositories.dart';
import 'package:marcahoras3/data_layer/web.dart';
import 'package:marcahoras3/domain_layer/usecases.dart';
import 'package:marcahoras3/utils/utils.dart';

void main() {
  final String fakeToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZDIwMjUxNi1iM2MxLTQ3ZWUtYmZmMy0zM2QzOGQ1ZTdiNzQiLCJyZWZyZXNoX3Rva2VuIjoiIiwiaWF0IjoxNzI4NDc1NTg3LCJleHAiOjE3Mjg3Nzc5ODd9.t9TZ-MgLh4HT2cVFtQ9z0wTwgGAejbPOYLWDFq9trMA";

  final connector = WebConnector("http://localhost:3000");
  connector.addInterceptor(InvalidUserInterceptor());
  final v = Vault();
  v.setVaultData(token: fakeToken, refreshToken: '');

  final initDate = DateTime(2024, 10, 01);
  final endDate =
      DateTime(initDate.year, initDate.month + 1, 1).add(Duration(days: -1));

  final fInitDate = formatDate(initDate, true);
  final fEndDate = formatDate(endDate, true);

  test('should generate the correct vigencia dates', () {
    final (inicio, termino) = getFormatedDateRange(2024, 10);

    print(inicio);
    print(termino);

    assert(inicio == "2024-10-01");
    assert(termino == "2024-10-31");
  });

  test('should list empregos', () async {
    try {
      final provider = EmpregosProvider(connector);
      final result = await provider.list(fInitDate, fEndDate);
      result.forEach((e) {
        print(e.horas);
        print(e.salarios);
      });
    } catch (e) {
      print("error $e");
    }
  });

  test('should list from usecase empregos', () async {
    try {
      final provider = EmpregosProvider(connector);
      final repo = EmpregoRepository(provider);
      final usecase = await EmpregoDataLoadUseCase(repo);

      final result = await usecase(fInitDate, fEndDate);

      result.forEach((e) {
        print(e.horas);
      });
    } catch (e) {
      print("error $e");
    }
  });
}
