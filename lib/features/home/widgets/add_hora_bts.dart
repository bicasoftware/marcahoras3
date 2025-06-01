import 'package:flutter/material.dart';

import '../../../domain_layer/models.dart';
import '../../../utils.dart';
import '../../../widgets.dart';

class AddHoraBts extends StatefulWidget {
  final DateTime initDate;
  final DateTime admissao;
  final Horas? hora;
  final bool feriado;
  final String empregoId;
  final TimeOfDay empregoEntrada;
  final bool hideDate;
  final bool bancoHoras;

  const AddHoraBts({
    required this.initDate,
    required this.empregoId,
    required this.empregoEntrada,
    required this.admissao,
    required this.bancoHoras,
    this.hideDate = false,
    this.hora,
    this.feriado = false,
    super.key,
  });

  @override
  State<AddHoraBts> createState() => _AddHoraBtsState();
}

class _AddHoraBtsState extends State<AddHoraBts> {
  late DateTime _date;
  bool _compensada = false;
  late TimeOfDay _entrada, _saida;
  late HorasType _horaType;

  @override
  void initState() {
    _date = widget.initDate;

    if (widget.hora != null) {
      _horaType = widget.hora!.tipoHora;
      _entrada = widget.hora!.inicio;
      _saida = widget.hora!.termino;
      _compensada = widget.hora!.horaStatus == HoraStatus.burned;
    } else {
      _horaType = HorasType.normal;
      _entrada = widget.empregoEntrada;
      _saida = TimeOfDayHelper.addHours(widget.empregoEntrada, 1);
    }

    super.initState();
  }

  void _onSave() {
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
        createdAt: DateTime.now(),
      );
    }

    Navigator.of(context).pop(resultHora);
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
                final date = await DialogHelper.showDateTimeDialog(
                  context: context,
                  initDate: _validDate(),
                  endDate: getLastDayOfMonth(_date),
                  admissao: widget.admissao,
                  allowFutureDates: true,
                );

                setState(() => _date = date ?? _date);
              },
              icon: Icons.calendar_month,
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
                  onSelectionChanged: (type) {
                    setState(() => _horaType = type);
                  },
                ),

          OutlinedButton.icon(
            onPressed: _onSave,
            icon: Icon(Icons.save_outlined),
            label: Text(Localiza.find('salvar')),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
