import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../resources/localizations/strings.dart';
import '../../../utils/utils.dart';

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

  String _valorHora() {
    final porc = hora.tipoHora == HorasType.normal
        ? emprego.porcNormal
        : emprego.porcFeriado;

    final valor = CalcHelper.calcPorcentagemHora(
      _salario(),
      emprego.cargaHoraria,
      porc,
    );

    return CurrencyHelper.formatAmount(valor);
  }

  String _horasTrabalhadas() {
    final inicio = hora.inicio.toTimeOfDay();
    final termino = hora.termino.toTimeOfDay();

    return "${termino.hour - inicio.hour}";
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _IconLabel(
                  icon: Icons.timeline,
                  iconColor: AppColors.primary,
                  label: "${strings.horasTrabalhadas}: ${_horasTrabalhadas()}",
                ),
                _IconLabel(
                  icon: Icons.payments_outlined,
                  iconColor: _tipoHoraColor(),
                  label: "${strings.valorReceber}: ${_valorHora()}",
                ),
                _IconLabel(
                  icon: Icons.payment,
                  iconColor: AppColors.secondary,
                  label:
                      "${strings.salario}: ${CurrencyHelper.formatAmount(_salario())}",
                ),
              ],
            ),
          ),
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

class _IconLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;

  const _IconLabel({
    required this.label,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Icon(
              icon,
              size: 16,
              color: iconColor,
            ),
          ),
          Text(
            label,
            style: theme.labelLarge?.copyWith(
              fontWeight: FontWeight.normal,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
