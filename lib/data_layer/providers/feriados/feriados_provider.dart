import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../contracts.dart';
import '../../database/db_connector_drift.dart';
import '../../dtos.dart';
import '../../providers.dart';

class FeriadosProvider implements FeriadosContract {
  final http.Client _client;
  final FeriadosProviderSqlite _sqlProvider;

  FeriadosProvider({
    required http.Client client,
    required AppDatabase db,
  }) : _client = client,
       _sqlProvider = FeriadosProviderSqlite(db: db);

  @override
  Future<List<FeriadosDto>> fetchFeriados(int year) async {
    final feriados = await _sqlProvider.fetchFeriados(year);

    if (feriados.length == 0) {
      /// TODO - remover essa string direta ao implementar um arquivo com as endpoints
      final url = Uri.parse('https://brasilapi.com.br/api/feriados/v1/$year');

      final response = await _client.get(url);

      if (response.statusCode != 200) {
        throw http.ClientException(
          'Failed to load feriados: ${response.statusCode}',
          url,
        );
      }

      final decoded = jsonDecode(response.body) as List<dynamic>;
      return _sqlProvider.insertFeriados(FeriadosDto.fromJsonList(decoded));
    }

    return feriados;
  }

  @override
  Future<List<FeriadosDto>> insertFeriados(
    List<FeriadosDto> feriadosList,
  ) async {
    /// This shouldn't be called, so return empty
    return [];
  }
}
