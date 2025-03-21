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

  const AddHoraBts({
    required this.initDate,
    required this.empregoId,
    required this.empregoEntrada,
    required this.admissao,
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
  bool _feriado = false;
  late TimeOfDay _entrada, _saida;

  @override
  void initState() {
    if (widget.hora != null) {
      _date = widget.initDate;
      _feriado = widget.hora!.tipoHora == HorasType.feriado;
      _entrada = widget.hora!.inicio;
      _saida = widget.hora!.termino;
    } else {
      _date = widget.initDate;
      _feriado = widget.feriado;
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
        tipoHora: _feriado == true ? HorasType.feriado : HorasType.normal,
      );
    } else {
      resultHora = Horas(
        empregoId: widget.empregoId,
        inicio: _entrada,
        termino: _saida,
        data: _date,
        tipoHora: _feriado == true ? HorasType.feriado : HorasType.normal,
        bancoHoras: false,
      );
    }

    Navigator.of(context).pop(resultHora);
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
          if (!widget.hideDate) ...[
            ShLabeledTile(
              value: formatDateByLocale(_date, locale),
              label: Localiza.find('data'),
              onTap: () async {
                final date = await DialogHelper.showDateTimeDialog(
                  context: context,
                  initDate: _date,
                  admissao: widget.admissao,
                  allowFutureDates: true,
                );

                setState(() => _date = date ?? _date);
              },
              icon: Icons.calendar_month,
            ),
          ],
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
          ShSwitchTile(
            value: _feriado,
            label: Localiza.find('feriado'),
            onTap: (_) {
              setState(() => _feriado = !_feriado);
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
