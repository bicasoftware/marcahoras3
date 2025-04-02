import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcahoras3/utils/currency_helper.dart';
import 'package:marcahoras3/utils/date_utils.dart';
import 'package:marcahoras3/widgets/dialogs/vigencia_picker_dialog.dart';

import '../../../utils/localiza/localiza.dart';
import '../../../widgets.dart';

class SalariosDetailBts extends StatefulWidget {
  final double value;
  final DateTime vigencia;
  final String title;
  final void Function(double value, DateTime vigencia) onSave;

  const SalariosDetailBts({
    required this.title,
    required this.onSave,
    required this.vigencia,
    this.value = 0.0,
    super.key,
  });

  @override
  State<SalariosDetailBts> createState() => _SalariosDetailBtsState();
}

class _SalariosDetailBtsState extends State<SalariosDetailBts> {
  late final MoneyMaskedTextController amountController;
  late int _year, _month;
  final controller = FixedExtentScrollController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    amountController = MoneyMaskedTextController(initialValue: widget.value);

    _year = widget.vigencia.year;
    _month = widget.vigencia.month;

    super.initState();
  }

  void _validate() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop();
      widget.onSave(amountController.numberValue, DateTime(_year, _month, 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            Text(
              widget.title,
              style: theme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            ShTextTile(
              controller: amountController,
              label: Localiza.find("salario"),
              hint: CurrencyHelper.formatAmount(1000),
              labelStyle: theme.labelLarge,
              icon: Icon(Icons.monetization_on),
              validator: (_) {
                final amount = amountController.numberValue;
                if (amount <= 0.0) {
                  return Localiza.find('salarioInvalido');
                } else if (amount < widget.value) {
                  return Localiza.find('salarioMenor');
                }

                return null;
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            ),
            ShLabeledTile(
              value: formatVigencia(_year, _month),
              label: Localiza.find("vigencia"),
              icon: Icons.calendar_month,
              onTap: () async {
                final newVig = await showVigenciaPickerDialog(
                  context: context,
                  titleMsg: Localiza.find('vigencia'),
                  descriptionText: '',
                  ano: widget.vigencia.year,
                  mes: widget.vigencia.month,
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
              child: OutlinedButton.icon(
                onPressed: _validate,
                icon: Icon(Icons.save_outlined),
                label: Text(Localiza.find("salvar")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
