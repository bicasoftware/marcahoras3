import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../presentation_layer/validators/validators.dart';
import '../../../utils/localiza/localiza.dart';
import '../../../widgets.dart';

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
  late int year, month;
  final yearList = List<int>.generate(6, (i) => 2019 + i);
  final controller = FixedExtentScrollController();

  @override
  void initState() {
    amountController = MoneyMaskedTextController(initialValue: widget.value);
    year = widget.vigencia?.year ?? _vigencia.year;
    month = widget.vigencia?.month ?? _vigencia.month;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final months = Localiza.findList("months");

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
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
            hint: "R\$ 1000,00",
            labelStyle: theme.labelLarge,
            icon: Icon(Icons.monetization_on),
            validator: (s) {
              if (amountController.numberValue <= 0.0) {
                return "Salário deve ser preenchido corretamente";
              }
              return MinCharactersValidator.validate(s, 6);
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          ShCustomLabelTile(
            label: Localiza.find("vigencia"),
            icon: Icons.calendar_month,
            child: Container(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ShScrollablePicker<String>(
                        items: months,
                        selectedItem: months[month - 1],
                        valueFormatter: <int>(item) => item.toString(),
                        onItemSelected: (int pos) {
                          setState(() => month = pos + 1);
                        },
                      ),
                    ),
                    Expanded(
                      child: ShScrollablePicker<int>(
                        items: yearList,
                        selectedItem: year,
                        valueFormatter: <int>(item) => item.toString(),
                        onItemSelected: (int selection) {
                          setState(() => year = yearList[selection]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: EdgeInsets.only(bottom: 16),
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onSave(
                  amountController.numberValue,
                  DateTime(year, month, 1),
                );
              },
              icon: Icon(Icons.save_outlined),
              label: Text(Localiza.find("salvar")),
            ),
          ),
        ],
      ),
    );
  }
}
