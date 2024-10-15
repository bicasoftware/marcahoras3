import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets/dialogs/dialog_helper.dart';
import 'package:marcahoras3/widgets/sh_time_range_picker.dart';

import '../../../domain_layer/models.dart';
import '../../../resources.dart';
import '../../../utils/utils.dart';
import '../../../widgets.dart';

class AddHoraBts extends StatefulWidget {
  final DateTime initDate;
  final Horas? hora;
  final bool feriado;
  final String empregoId;
  final TimeOfDay empregoEntrada;
  final bool hideDate;

  const AddHoraBts({
    required this.initDate,
    required this.empregoId,
    required this.empregoEntrada,
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
      _entrada = widget.hora!.inicio.toTimeOfDay();
      _saida = widget.hora!.termino.toTimeOfDay();
    } else {
      _date = widget.initDate;
      _feriado = widget.feriado;
      _entrada = widget.empregoEntrada;
      _saida = widget.empregoEntrada.addHours(1);
    }

    super.initState();
  }

  void _onSave() {
    final Horas resultHora;
    if (widget.hora != null) {
      resultHora = widget.hora!.copyWith(
        inicio: _entrada.asString(),
        termino: _saida.asString(),
        tipoHora: _feriado == true ? HorasType.feriado : HorasType.normal,
      );
    } else {
      resultHora = Horas(
        empregoId: widget.empregoId,
        inicio: _entrada.asString(),
        termino: _saida.asString(),
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
    final strings = context.strings();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (!widget.hideDate) ...[
            ShLabeledTile(
              value: formatDateByLocale(
                _date,
                locale,
              ),
              label: strings.data,
              onTap: () async {
                final date = await DialogHelper.showDateTimeDialog(
                  context,
                  _date,
                );

                setState(() => _date = date ?? _date);
              },
              icon: Icons.calendar_month,
            ),
            const SizedBox(height: 8),
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
          const SizedBox(height: 8),
          ShSwitchTile(
            value: _feriado,
            label: strings.feriado,
            onTap: (_) {
              setState(() => _feriado = !_feriado);
            },
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _onSave,
            icon: Icon(Icons.save_outlined),
            label: Text(
              strings.salvar,
            ),
          )
        ],
      ),
    );
  }
}
