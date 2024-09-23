import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcahoras3/features/empregos/salarios_tile_item.dart';
import 'package:marcahoras3/utils/date_utils.dart';

import '../../domain_layer/models.dart';
import '../../presentation_layer/validators/validators.dart';
import '../../resources.dart';
import '../../widgets.dart';
import 'salarios_action_type.dart';

class SalariosTile extends StatefulWidget {
  final List<Salarios> salarios;
  final ValueChanged<SalariosActionType> onOptionSelected;
  final ValueChanged<String> onSalarioValueChanged;
  final bool isEditing;
  final MoneyMaskedTextController controller;

  const SalariosTile({
    required this.salarios,
    required this.onOptionSelected,
    required this.onSalarioValueChanged,
    required this.isEditing,
    required this.controller,
    super.key,
  });

  @override
  State<SalariosTile> createState() => _SalariosTileState();
}

class _SalariosTileState extends State<SalariosTile> {
  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final theme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);

    return widget.isEditing
        ? IndicatorTile(
            child: ListTile(
              title: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  strings.salario,
                  style: theme.labelLarge,
                ),
              ),
              subtitle: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.salarios.length,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) {
                  return index & 1 == 0
                      ? Divider(
                          thickness: 1,
                          height: 16,
                        )
                      : Container();
                },
                itemBuilder: (context, index) {
                  final s = widget.salarios[index];

                  return SalariosTileItem(
                    vigencia:
                        formatVigenciaDate(s.vigencia, locale, 'MMMM/yyyy'),
                    valor: s.valor.toString(),
                    onDelete: () {
                      print('delete');
                    },
                    onEdit: () {
                      print('edit');
                    },
                  );
                },
              ),
              leading: Icon(Icons.monetization_on),
              contentPadding: EdgeInsets.only(left: 16),
              trailing: PopupMenuButton<SalariosActionType>(
                onSelected: widget.onOptionSelected,
                itemBuilder: (c) => SalariosActionType.values
                    .map(
                      (o) => PopupMenuItem<SalariosActionType>(
                        child: Text(o == SalariosActionType.aumento
                            ? strings.recebiAumento
                            : strings.alterarValor),
                        value: o,
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        // ? ShLabeledTile(
        //     value: "1200,00",
        //     label: strings.valorSalario,
        //     icon: Icons.monetization_on,
        //     trailing: PopupMenuButton<SalariosActionType>(
        //       onSelected: widget.onOptionSelected,
        //       itemBuilder: (c) => SalariosActionType.values
        //           .map(
        //             (o) => PopupMenuItem<SalariosActionType>(
        //               child: Text(o == SalariosActionType.aumento
        //                   ? strings.recebiAumento
        //                   : strings.alterarValor),
        //               value: o,
        //             ),
        //           )
        //           .toList(),
        //     ),
        //   )
        : ShTextTile(
            controller: widget.controller,
            label: strings.salario,
            hint: "R\$ 1000,00",
            labelStyle: theme.labelLarge,
            icon: Icon(Icons.monetization_on),
            onValueChanged: widget.onSalarioValueChanged,
            validator: (s) {
              if (widget.controller.numberValue <= 0.0) {
                return "Salário deve ser preenchido corretamente";
              }
              return MinCharactersValidator.validate(s, 6, strings);
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
          );
  }
}

class _SalariosInputTile extends StatelessWidget {
  const _SalariosInputTile({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return ShLabeledTile(
      value: "1200,00",
      label: strings.valorSalario,
      icon: Icons.monetization_on,
      // trailing: PopupMenuButton<SalariosActionType>(
      //   onSelected: widget.onOptionSelected,
      //   itemBuilder: (c) => SalariosActionType.values
      //       .map(
      //         (o) => PopupMenuItem<SalariosActionType>(
      //           child: Text(o == SalariosActionType.aumento
      //               ? strings.recebiAumento
      //               : strings.alterarValor),
      //           value: o,
      //         ),
      //       )
      //       .toList(),
      // ),
      // trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
    );
  }
}
