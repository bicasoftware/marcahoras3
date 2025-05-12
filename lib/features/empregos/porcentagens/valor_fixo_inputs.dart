import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../presentation_layer/validators/validators.dart';
import '../../../resources.dart';
import '../../../utils.dart';
import '../../../widgets.dart';

class ValorFixoInputs extends StatefulWidget {
  final ValueChanged<double> onNormalChanged, onFeriadoChanged;
  final double initNormalValue, initFeriadoValue;
  final bool canEdit;

  const ValorFixoInputs({
    super.key,
    required this.onNormalChanged,
    required this.onFeriadoChanged,
    required this.initNormalValue,
    required this.initFeriadoValue,
    this.canEdit = false,
  });

  @override
  State<ValorFixoInputs> createState() => _ValorFixoInputsState();
}

class _ValorFixoInputsState extends State<ValorFixoInputs> {
  late final MoneyMaskedTextController _normalController, _feriadoController;

  @override
  void initState() {
    _normalController = MoneyMaskedTextController(
      initialValue: widget.initNormalValue,
    );
    _feriadoController = MoneyMaskedTextController(
      initialValue: widget.initFeriadoValue,
    );
    super.initState();
  }

  @override
  void dispose() {
    _normalController.dispose();
    _feriadoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return IgnorePointer(
      ignoring: !widget.canEdit,
      child: Column(
        spacing: 4,
        children: [
          ShTextTile(
            controller: _normalController,
            label: Localiza.find('valorFixoNormal'),
            hint: CurrencyHelper.formatAmount(12),
            labelStyle: theme.labelLarge,
            icon: Icon(Icons.monetization_on, color: AppColors.porcNormalColor),
            onValueChanged:
                (_) => widget.onNormalChanged(_normalController.numberValue),
            validator: (s) {
              if (_normalController.numberValue <= 0.0) {
                return Localiza.find('valorInvalido');                
              }
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          ShTextTile(
            controller: _feriadoController,
            label: Localiza.find('valorFixoFeriados'),
            hint: CurrencyHelper.formatAmount(12),
            labelStyle: theme.labelLarge,
            icon: Icon(Icons.monetization_on, color: AppColors.porcFeriadosColor),
            onValueChanged:
                (_) => widget.onFeriadoChanged(_feriadoController.numberValue),
            validator: (s) {
              if (_feriadoController.numberValue <= 0.0) {
                return Localiza.find('valorInvalido');
              }
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
