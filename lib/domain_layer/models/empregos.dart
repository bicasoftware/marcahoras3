import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';
import '../models.dart';

@immutable
class Empregos {
  final String? id;
  final String descricao;
  final DateTime? admissao;
  final TimeOfDay entrada;
  final TimeOfDay saida;
  final bool bancoHoras;
  final int porcFeriado;
  final int porcNormal;
  final int cargaHoraria;
  final bool ativo;
  final int diaFechamento;

  final double salario;

  final UnmodifiableListView<Horas> horas;
  final UnmodifiableListView<Salarios> salarios;
  final UnmodifiableListView<HoraFixo> horaFixoList;
  final UnmodifiableListView<Diferenciais> diferenciaisList;

  Empregos({
    this.id,
    this.descricao = '',
    this.admissao,
    this.entrada = const TimeOfDay(hour: 8, minute: 0),
    this.saida = const TimeOfDay(hour: 18, minute: 0),
    this.bancoHoras = false,
    this.porcFeriado = 100,
    this.porcNormal = 50,
    this.cargaHoraria = 220,
    this.ativo = true,
    this.salario = 0.0,
    this.diaFechamento = 25,
    Iterable<Horas> horas = const [],
    Iterable<Salarios> salarios = const [],
    Iterable<HoraFixo> horaFixoList = const [],
    Iterable<Diferenciais> diferenciaisList = const [],
  }) : horas = UnmodifiableListView(horas),
       salarios = UnmodifiableListView(salarios),
       horaFixoList = UnmodifiableListView(horaFixoList),
       diferenciaisList = UnmodifiableListView(
         diferenciaisList..sortedBy((d) => d.weekday),
       );

  Empregos copyWith({
    String? id,
    String? descricao,
    DateTime? admissao,
    TimeOfDay? entrada,
    TimeOfDay? saida,
    bool? bancoHoras,
    int? porcFeriado,
    int? porcNormal,
    int? cargaHoraria,
    bool? ativo,
    double? salario,
    int? diaFechamento,
    Iterable<Horas>? horas,
    Iterable<Salarios>? salarios,
    Iterable<HoraFixo>? horaFixoList,
    Iterable<Diferenciais>? diferenciaisList,
  }) {
    return Empregos(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      admissao: admissao ?? this.admissao,
      entrada: entrada ?? this.entrada,
      saida: saida ?? this.saida,
      bancoHoras: bancoHoras ?? this.bancoHoras,
      porcFeriado: porcFeriado ?? this.porcFeriado,
      porcNormal: porcNormal ?? this.porcNormal,
      cargaHoraria: cargaHoraria ?? this.cargaHoraria,
      ativo: ativo ?? this.ativo,
      diaFechamento: diaFechamento ?? this.diaFechamento,
      horas: horas ?? this.horas,
      salarios: salarios ?? this.salarios,
      salario: salario ?? this.salario,
      horaFixoList: horaFixoList ?? this.horaFixoList,
      diferenciaisList: diferenciaisList ?? this.diferenciaisList,
    );
  }

  factory Empregos.empty() {
    final now = DateTime.now();
    return Empregos(
      id: generateId(),
      ativo: true,
      admissao: now,
      cargaHoraria: CargaHoraria.padrao.mensal,
      porcNormal: 50,
      porcFeriado: 100,
      saida: TimeOfDay(hour: 17, minute: 00),
      diaFechamento: 25,
      salarios: [
        Salarios(
          id: generateId(),
          empregoId: '',
          vigencia: buildVigencia(now.year, now.month),
          valor: 0,
          ativo: true,
        ),
      ],
    );
  }

  Salarios getSalarioByVigencia(int year, int month, int fechamento) {
    assert(salarios.isNotEmpty);

    if (salarios.length == 1) return salarios.first;
    return salarios
        .sorted((a, b) => a.vigencia.compareTo(b.vigencia))
        .reversed
        .firstWhere(
          (s) =>
              compareVigenciaByYearMonth(year, month, fechamento, s.vigencia),
        );
  }

  double getCurrentSalario() {
    final today = DateTime.now();
    int year = today.year;
    int month = today.month;

    if (salarios.length == 1) {
      return salarios.first.valor;
    } else {
      final atual = salarios
          .sorted((a, b) => a.vigencia.compareTo(b.vigencia))
          .reversed
          .firstWhereOrNull(
            (s) => compareVigenciaByYearMonth(
              year,
              month,
              diaFechamento,
              s.vigencia,
            ),
          );

      return atual?.valor ?? 0;
    }
  }

  ValorFixo? getCurrentValorFixo() {
    return horaFixoList
        .sorted((a, b) => a.vigencia.compareTo(b.vigencia))
        .lastOrNull
        ?.toValorFixo();
  }

  ValorFixo? getValorFixoByVigencia(int year, int month) {
    if (horaFixoList.isEmpty) return null;
    if (horaFixoList.length == 1) return horaFixoList.first.toValorFixo();

    final _vig = DateTime(year, month, 1);
    return horaFixoList
        .sorted((a, b) => a.vigencia.compareTo(b.vigencia))
        .reversed
        .firstWhereOrNull((s) => s.vigencia.isSameDayOfBefore(_vig))
        ?.toValorFixo();
  }

  @override
  bool operator ==(covariant Empregos other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.descricao == descricao &&
      other.admissao == admissao &&
      other.entrada == entrada &&
      other.saida == saida &&
      other.bancoHoras == bancoHoras &&
      other.porcFeriado == porcFeriado &&
      other.porcNormal == porcNormal &&
      other.cargaHoraria == cargaHoraria &&
      other.ativo == ativo &&
      other.diaFechamento == diaFechamento &&
      other.salario == salario &&
      other.horas == horas &&
      other.salarios == salarios &&
      other.horaFixoList == horaFixoList &&
      other.diferenciaisList == diferenciaisList;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      descricao.hashCode ^
      admissao.hashCode ^
      entrada.hashCode ^
      saida.hashCode ^
      bancoHoras.hashCode ^
      porcFeriado.hashCode ^
      porcNormal.hashCode ^
      cargaHoraria.hashCode ^
      ativo.hashCode ^
      diaFechamento.hashCode ^
      salario.hashCode ^
      horas.hashCode ^
      salarios.hashCode ^
      horaFixoList.hashCode ^
      diferenciaisList.hashCode;
  }

  @override
  String toString() {
    return 'Empregos(id: $id, descricao: $descricao, admissao: $admissao, entrada: $entrada, saida: $saida, bancoHoras: $bancoHoras, porcFeriado: $porcFeriado, porcNormal: $porcNormal, cargaHoraria: $cargaHoraria, ativo: $ativo, diaFechamento: $diaFechamento, salario: $salario, horas: $horas, salarios: $salarios, horaFixoList: $horaFixoList, diferenciaisList: $diferenciaisList)';
  }
}

class FechamentoRange {
  final DateTime inicio, termino;

  const FechamentoRange({required this.inicio, required this.termino});
}

enum CargaHoraria {
  padrao(44, 220),
  reduzida(40, 200),
  reduzida2(36, 180),
  reduzida3(30, 150)
  ;

  final int mensal;
  final int semanal;

  const CargaHoraria(this.semanal, this.mensal);

  static CargaHoraria getByMensal(int mensal) {
    return CargaHoraria.values.firstWhere(
      (a) => a.mensal == mensal,
      orElse: () => padrao,
    );
  }

  static CargaHoraria getBySemanal(int semanal) {
    return CargaHoraria.values.firstWhere(
      (a) => a.semanal == semanal,
      orElse: () => padrao,
    );
  }

  static List<int> get mensais =>
      CargaHoraria.values.map((c) => c.mensal).toList();

  static List<int> get semanais =>
      CargaHoraria.values.map((c) => c.semanal).toList();
}
