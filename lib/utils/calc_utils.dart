import 'package:flutter/material.dart';
import 'package:marcahoras3/utils/extensions.dart';

class CalcHelper {
  static double salarioHora(double salario, int carga) {
    return salario / carga;
  }

  static double salarioMinuto(double salario, int carga) {
    return salarioHora(salario, carga) / 60;
  }

  static double calcPorcentagemHora({
    required double salario,
    required int cargaHoraria,
    required int porcentagem,
  }) {
    final salHora = salarioHora(salario, cargaHoraria);
    return (salHora * (1 + (porcentagem / 100)));
  }

  static double calcPorcentagem(double minutos, int porc) {
    return double.parse((minutos * (1 + (porc / 100))).toStringAsPrecision(2));
  }

  static double calcValorReceber({
    required double salario,
    required TimeOfDay from,
    required TimeOfDay to,
    required int cargaHoraria,
    required int porcentagem,
    double? valorFixo,
  }) {
    double salMinute = 0.0;
    if (valorFixo == null) {
      final salorioHora = salario / cargaHoraria;
      final valorHora = salorioHora * (1 + (porcentagem / 100));
      salMinute = valorHora / 60;
    } else {
      salMinute = valorFixo / 60;
    }

    final minutes = TimeOfDayHelper.getMinutesBetweenTimes(from, to);

    return minutes * salMinute;
  }
}
