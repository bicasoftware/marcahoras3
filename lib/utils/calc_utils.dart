class CalcHelper {
  static double salarioHora(double salario, int carga) {
    return double.parse((salario / carga).toStringAsFixed(2));
  }

  static double calcPorcentagemHora(double salario, int carga, int porc) {
    final salHora = salarioHora(salario, carga);
    return (salHora * (1 + (porc / 100)));
  }

  static double salarioMinuto(double salario, int carga) {
    return double.parse(
      (salarioHora(salario, carga) / 60).toStringAsPrecision(2),
    );
  }

  static double calcPorcentagem(double minutos, int porc) {
    return double.parse((minutos * (1 + (porc / 100))).toStringAsPrecision(2));
  }
}