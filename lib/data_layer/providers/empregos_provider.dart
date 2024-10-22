import 'dart:isolate';

import '../dtos.dart';
import '../web.dart';

class EmpregosProvider {
  final WebConnector _connector;

  const EmpregosProvider(
    WebConnector connector,
  ) : _connector = connector;

  Future<List<EmpregosDto>> list(String from, String to) async {
    try {
      final response = await _connector.request(
        EndPoints.empregos,
        method: WebMethod.get,
        queryParams: {
          "from": from,
          "to": to,
        },
      );

      return response.isSuccess
          ? await Isolate.run(() {
              return EmpregosDto.fromJsonList(response.data);
            })
          : throw response.toWebException();
    } catch (e) {
      rethrow;
    }
  }

  Future<EmpregosDto> append(EmpregosDto e) async {
    try {
      final response = await _connector.request(
        EndPoints.empregos,
        method: WebMethod.post,
        data: e,
      );

      return response.isSuccess
          ? EmpregosDto.fromJson(response.data)
          : throw response.toWebException();
    } catch (e) {
      rethrow;
    }
  }

  Future<EmpregosDto> update(EmpregosDto emprego) async {
    try {
      final result = await _connector.request(
        EndPoints.empregos,
        method: WebMethod.patch,
        data: emprego,
      );

      return result.isSuccess
          ? EmpregosDto.fromJson(result.data)
          : throw result.toWebException();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String empregoId) async {
    try {
      final response = await _connector.request(
        "${EndPoints.empregos}/$empregoId",
        method: WebMethod.delete,
        queryParams: {
          "id": empregoId,
        },
      );

      if (!response.isSuccess) {
        throw response.toWebException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
