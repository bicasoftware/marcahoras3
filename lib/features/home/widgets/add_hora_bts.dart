import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../utils.dart';
import '../../../widgets.dart';

class AddHoraBts extends StatefulWidget {
  final DateTime initDate;
  final DateTime admissao;
  final Horas? hora;
  final Feriados? feriado;
  final String empregoId;
  final TimeOfDay empregoSaida;
  final bool hideDate;
  final bool bancoHoras;
  final Diferenciais? diferencial;

  const AddHoraBts({
    required this.initDate,
    required this.empregoId,
    required this.empregoSaida,
    required this.admissao,
    required this.bancoHoras,
    this.hideDate = false,
    this.hora,
    this.feriado,
    this.diferencial,
    super.key,
  });

  @override
  State<AddHoraBts> createState() => _AddHoraBtsState();
}

/// TODO - refazer esse widget todo para bater com o mesmo design do popup number picker

class _AddHoraBtsState extends State<AddHoraBts> {
  late DateTime _date;
  bool _compensada = false;
  late TimeOfDay _entrada, _saida;
  late HorasType _horaType;

  @override
  void initState() {
    _date = widget.initDate;

    if (widget.hora != null) {
      _horaType = widget.diferencial != null
          ? HorasType.diferencial
          : widget.hora!.tipoHora;
      _entrada = widget.hora!.inicio;
      _saida = widget.hora!.termino;
      _compensada = widget.hora!.horaStatus == HoraStatus.burned;
    } else {
      _horaType = widget.feriado != null ? HorasType.feriado : HorasType.normal;
      _entrada = widget.empregoSaida;
      _saida = _entrada.addHour(1);
    }

    super.initState();
  }

  void _onSave() {
    if (_saida.isSameTimeOrBefore(_entrada)) {
      showErrorDialog(
        context: context,
        errorMsg: Localiza.find('expt_hora_termino_antes_inicio'),
      );
    } else {
      final Horas resultHora;
      if (widget.hora != null) {
        resultHora = widget.hora!.copyWith(
          inicio: _entrada,
          termino: _saida,
          tipoHora: _horaType,
          horaStatus: _getHoraStatus(),
        );
      } else {
        resultHora = Horas(
          empregoId: widget.empregoId,
          inicio: _entrada,
          termino: _saida,
          data: _date,
          tipoHora: _horaType,
          horaStatus: _getHoraStatus(),
        );
      }

      Navigator.of(context).pop(resultHora);
    }
  }

  HoraStatus _getHoraStatus() {
    if (widget.bancoHoras && _compensada) {
      return HoraStatus.burned;
    }

    return HoraStatus.active;
  }

  DateTime _validDate() {
    return _date.isBefore(widget.admissao) ? widget.admissao : _date;
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 8,
        children: [
          if (!widget.hideDate)
            ShLabeledTile(
              value: formatDateByLocale(_validDate(), locale),
              label: Localiza.find('data'),
              onTap: () async {
                final date = await DialogHelper.showDateDialog(
                  context: context,
                  initDate: _validDate(),
                  endDate: getLastDayOfMonth(_date),
                  admissao: widget.admissao,
                  allowFutureDates: true,
                );

                setState(() => _date = date ?? _date);
              },
              icon: Icon(Icons.calendar_month),
            ),
          if (widget.feriado != null)
            ShLabeledTile(
              label: "Feriado:",
              value: widget.feriado!.nome,
              icon: Icon(Icons.info, color: ExtraColors.porcFeriadosColor),
            ),
          ShTimeRangePicker(
            initTime: _entrada,
            endTime: _saida,
            onEntradaChanged: (time) {
              setState(() => _entrada = time);
            },
            onSaidaChanged: (time) {
              setState(() => _saida = time);
            },
          ),
          widget.bancoHoras
              ? ShCheckBoxTile(
                  value: _compensada,
                  label: Localiza.find('compensada'),
                  onTap: (_) {
                    setState(() => _compensada = !_compensada);
                  },
                )
              : HoraTypeToggleButton(
                  horasType: _horaType,
                  diferencial: widget.diferencial,
                  onSelectionChanged: (type) {
                    setState(() => _horaType = type);
                  },
                ),
          ShFormButton.saveLight(_onSave),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
