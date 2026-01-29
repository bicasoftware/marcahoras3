import 'dart:convert';

import 'package:flutter/services.dart';

import '../../contracts.dart';
import '../../dtos.dart';
import '../../mappers.dart';

class FeriadosProvider implements FeriadosContract {
  FeriadosProvider();

  @override
  Future<List<AnosDto>> fetchAnos() async {
    final jsonString = await rootBundle.loadString('assets/feriados.json');
    final jsonObj = json.decode(jsonString);
    return AnosMapper.fromJsonList(jsonObj['anos']);
  }
}
