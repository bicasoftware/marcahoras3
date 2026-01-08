import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../utils.dart';
import '../../../widgets.dart';

class HorasListTile extends StatelessWidget {
  final Horas hora;
  final Empregos emprego;

  const HorasListTile({required this.hora, required this.emprego, super.key});

  double _salario() => emprego.getCurrentSalario().valor;

  double _valorHora() {
    final porc = hora.tipoHora == HorasType.normal
        ? emprego.porcNormal
        : emprego.porcFeriado;

    return CalcHelper.calcPorcentagemHora(
      salario: _salario(),
      cargaHoraria: emprego.cargaHoraria,
      porcentagem: porc,
    );
  }

  int _horasTrabalhadas() {
    return hora.termino.hour - hora.inicio.hour;
  }

  String _getLabel() {
    switch (hora.tipoHora) {
      case HorasType.feriado:
        return Localiza.find('horaFeriado');
      case HorasType.diferencial:
        return Localiza.find('diferencial');
      default:
        return Localiza.find('horaNormal');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final ht = _horasTrabalhadas();
    final vh = _valorHora();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconLabelValue(
                  icon: Icons.timeline,
                  iconColor: colors.primary,
                  label: Localiza.find('horasTrabalhadas'),
                  labelColor: colors.primary,
                  value: "$ht",
                ),
                IconLabelValue(
                  icon: Icons.payments_outlined,
                  iconColor: Color(hora.tipoHora.colorHex),
                  label: Localiza.find('valorReceber'),
                  value: CurrencyHelper.formatAmount(vh * ht),
                  labelColor: colors.primary,
                ),
                IconLabelValue(
                  icon: Icons.payment,
                  iconColor: colors.secondary,
                  label: Localiza.find('salario'),
                  labelColor: colors.primary,
                  value: CurrencyHelper.formatAmount(_salario()),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Badge(
            backgroundColor: Color(hora.tipoHora.colorHex),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            label: Text(
              _getLabel(),
            ),
          ),
        ],
      ),
    );
  }
}
