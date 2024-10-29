import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marcahoras3/utils/utils.dart';

void main() {
  group('CalcHelper', () {
    test(
        'salarioHora deve retornar o salário por hora arredondado para duas casas decimais',
        () {
      expect(CalcHelper.salarioHora(3000, 160), equals(18.75));
      expect(CalcHelper.salarioHora(2500, 150), equals(16.67));
      expect(CalcHelper.salarioHora(4000, 200), equals(20.0));
    });

    test(
        'salarioMinuto deve retornar o salário por minuto arredondado para duas casas decimais',
        () {
      expect(CalcHelper.salarioMinuto(3000, 160), equals(0.31));
      expect(CalcHelper.salarioMinuto(2500, 150), equals(0.28));
      expect(CalcHelper.salarioMinuto(4000, 200), equals(0.33));
    });

    test(
        'calcPorcentagem deve calcular o aumento de minutos conforme a porcentagem e arredondar',
        () {
      expect(CalcHelper.calcPorcentagem(60, 10), equals(66.0));
      expect(CalcHelper.calcPorcentagem(45, 20), equals(54.0));
      expect(CalcHelper.calcPorcentagem(30, 50), equals(45.0));
    });

    test('calcula porcentagem', () {
      final from = TimeOfDay(hour: 10, minute: 20);
      final to = TimeOfDay(hour: 11, minute: 40);

      final valor = CalcHelper.calcValorReceber(
        cargaHoraria: 220,
        from: from,
        to: to,
        porcentagem: 50,
        salario: 1200.0,
      );

      print(valor);
    });
  });
}
