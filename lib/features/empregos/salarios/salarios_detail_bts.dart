import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcahoras3/resources.dart';
import 'package:marcahoras3/utils/utils.dart';

import '../../../presentation_layer/validators/validators.dart';
import '../../../widgets.dart';
import '../../../widgets/bottomsheets/bts_container.dart';
import '../../../widgets/dialogs/time_picker_dialog.dart';

class SalariosDetailBts extends StatefulWidget {
  final double value;
  final DateTime? vigencia;
  final String title;
  final void Function(double value, DateTime vigencia) onSave;

  const SalariosDetailBts({
    required this.title,
    required this.onSave,
    this.value = 0.0,
    this.vigencia,
    super.key,
  });

  @override
  State<SalariosDetailBts> createState() => _SalariosDetailBtsState();
}

class _SalariosDetailBtsState extends State<SalariosDetailBts> {
  late final MoneyMaskedTextController amountController;
  DateTime _vigencia = DateTime.now();

  @override
  void initState() {
    amountController = MoneyMaskedTextController(initialValue: widget.value);
    super.initState();
  }

  Future<void> _selectVigencia(
    BuildContext context,
  ) async {
    final date = await vigenciaPicker(
      context: context,
      vigenciaInicial: _vigencia,
    );

    setState(() => _vigencia = date ?? _vigencia);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final theme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);

    return BtsContainer(
      title: widget.title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShTextTile(
            controller: amountController,
            label: strings.salario,
            hint: "R\$ 1000,00",
            labelStyle: theme.labelLarge,
            icon: Icon(Icons.monetization_on),
            validator: (s) {
              if (amountController.numberValue <= 0.0) {
                return "Salário deve ser preenchido corretamente";
              }
              return MinCharactersValidator.validate(s, 6, strings);
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          ShLabeledTile(
            value: formatVigenciaDate(_vigencia, locale, "MMMM yyyy"),
            label: strings.vigencia,
            onTap: () => _selectVigencia(context),
            icon: Icons.calendar_month,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onSave(amountController.numberValue, _vigencia);
              },
              icon: Icon(Icons.save_outlined),
              label: Text(strings.salvar),
            ),
          ),
        ],
      ),
    );
  }
}
