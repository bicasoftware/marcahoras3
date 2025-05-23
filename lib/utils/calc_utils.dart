import 'package:flutter/material.dart';
import 'package:marcahoras3/utils/extensions.dart';

class CalcHelper {
  static double salarioHora(double salario, int carga) {
    return salario / carga;
  }

  static double salarioMinuto(double salario, int carga) {
    return salarioHora(salario, carga) / 60;
  }

  static double calcPorcentagemHora(double salario, int carga, int porc) {
    final salHora = salarioHora(salario, carga);
    return (salHora * (1 + (porc / 100)));
  }

  static double calcValorReceber({
    required double salario,
    required TimeOfDay from,
    required TimeOfDay to,
    required int cargaHoraria,
    required int porcentagem,
  }) {
    final salorioHora = salario / cargaHoraria;
    final valorHora = salorioHora * (1 + (porcentagem / 100));
    final salMinute = valorHora / 60;
    final minutes = TimeOfDayHelper.getMinutesBetweenTimes(from, to);

    return minutes * salMinute;
  }

  static double calcValorReceberFixo({    
    required TimeOfDay from,
    required TimeOfDay to,
    required double valorFixo,
  }) {    
    final salMinute = valorFixo / 60;
    final minutes = TimeOfDayHelper.getMinutesBetweenTimes(from, to);

    return minutes * salMinute;
  }

  static double calcPorcentagem(double minutos, int porc) {
    return double.parse((minutos * (1 + (porc / 100))).toStringAsPrecision(2));
  }
}
