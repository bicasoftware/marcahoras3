import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../resources/localizations/strings.dart';
import '../../../utils/utils.dart';
import '../../../widgets/icon_label_value.dart';

class HorasListTile extends StatelessWidget {
  final Horas hora;
  final Empregos emprego;

  const HorasListTile({
    required this.hora,
    required this.emprego,
    super.key,
  });

  Color _tipoHoraColor() {
    return Color(hora.tipoHora.colorHex);
  }

  String _tipoHoraLabel(StringsContract strings) {
    return hora.tipoHora == HorasType.normal
        ? strings.horaNormal
        : strings.horaFeriado;
  }

  double _salario() => emprego.getCurrentSalario()?.valor ?? 0.0;

  double _valorHora() {
    final porc = hora.tipoHora == HorasType.normal
        ? emprego.porcNormal
        : emprego.porcFeriado;

    return CalcHelper.calcPorcentagemHora(
      _salario(),
      emprego.cargaHoraria,
      porc,
    );
  }

  int _horasTrabalhadas() {
    return hora.termino.hour - hora.inicio.hour;
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
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
                  iconColor: AppColors.primary,
                  label: strings.horasTrabalhadas,
                  labelColor: AppColors.primary,
                  value: "$ht",
                ),
                IconLabelValue(
                  icon: Icons.payments_outlined,
                  iconColor: _tipoHoraColor(),
                  label: strings.valorReceber,
                  value: CurrencyHelper.formatAmount(vh * ht),
                  labelColor: AppColors.primary,
                ),
                IconLabelValue(
                  icon: Icons.payment,
                  iconColor: AppColors.secondary,
                  label: strings.salario,
                  labelColor: AppColors.primary,
                  value: CurrencyHelper.formatAmount(
                    _salario(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Badge(
            backgroundColor: _tipoHoraColor(),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            label: Text(
              _tipoHoraLabel(strings),
            ),
          ),
        ],
      ),
    );
  }
}
