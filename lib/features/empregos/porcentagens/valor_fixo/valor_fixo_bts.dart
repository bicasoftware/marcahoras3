import 'package:flutter/material.dart';

import '../../../../utils.dart';
import '../../../../widgets.dart';
import '../../../../widgets/dialogs/vigencia_picker_dialog.dart';
import 'valor_fixo_inputs.dart';

class ValorFixoBts extends StatefulWidget {
  final DateTime vigencia;
  final ValorFixo valorFixo;
  final void Function(ValorFixo valorFixo, DateTime vigencia) onSave;
  final bool isInsert;

  const ValorFixoBts({
    required this.vigencia,
    required this.valorFixo,
    required this.onSave,
    this.isInsert = true,
  });

  @override
  State<ValorFixoBts> createState() => _ValorFixoBtsState();
}

class _ValorFixoBtsState extends State<ValorFixoBts> {
  late int _year, _month;
  late ValorFixo _valorFixo;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _year = widget.vigencia.year;
    _month = widget.vigencia.month;
    _valorFixo = widget.valorFixo;
    super.initState();
  }

  void _validate() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop();
      widget.onSave(_valorFixo, DateTime(_year, _month, 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 4,
          children: [
            Text(
              widget.isInsert
                  ? Localiza.find("novoValorFixo")
                  : Localiza.find("alterarValorFixo"),
              textAlign: TextAlign.start,
              style: theme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            ValorFixoInputs(
              initNormalValue: _valorFixo.$1,
              initFeriadoValue: _valorFixo.$2,
              canEdit: true,
              onNormalChanged: (v) => _valorFixo = (v, _valorFixo.$2),
              onFeriadoChanged: (v) => _valorFixo = (_valorFixo.$1, v),
            ),

            ShLabeledTile(
              value: formatVigencia(_year, _month, locale, "MMMM yyyy"),
              label: Localiza.find("vigencia"),
              icon: Icons.calendar_month,
              onTap: () async {
                final newVig = await showVigenciaPickerDialog(
                  context: context,
                  titleMsg: Localiza.find('vigencia'),
                  descriptionText: '',
                  ano: _year,
                  mes: _month,
                );

                if (newVig != null) {
                  setState(() {
                    _year = newVig.$1;
                    _month = newVig.$2;
                  });
                }
              },
            ),

            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: ShWideButton(
                onTap: _validate,
                labelId: "salvar",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
