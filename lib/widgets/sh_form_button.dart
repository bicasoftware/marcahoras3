import 'package:flutter/material.dart';

import '../resources.dart';
import '../utils.dart';

class ShFormButton extends StatelessWidget {
  final String textId;
  final IconData icon;
  final VoidCallback onTap;
  final Color? bgColor, fgColor;

  ShFormButton({
    required this.textId,
    required this.icon,
    required this.onTap,
    required this.bgColor,
    required this.fgColor,
    super.key,
  });

  ShFormButton.save(
    this.onTap, {
    super.key,
  }) : textId = 'salvar',
       icon = Icons.save,
       bgColor = ExtraColors.saveButtonColor,
       fgColor = ShAppTheme.onSaveButtonColor;
  
  ShFormButton.saveLight(
    this.onTap, {
    super.key,
  }) : textId = 'salvar',
       icon = Icons.save,
       bgColor = ShAppTheme.addButtonColor,
       fgColor = ShAppTheme.onAddButtonColor;

  ShFormButton.update(this.onTap, {super.key})
    : textId = 'atualizar',
      icon = Icons.refresh,
      bgColor = ShAppTheme.saveButtonColor,
      fgColor = ShAppTheme.onSaveButtonColor;

  ShFormButton.add(
    this.onTap, {
    super.key,
  }) : textId = 'adicionar',
       icon = Icons.add,
       bgColor = ShAppTheme.addButtonColor,
       fgColor = ShAppTheme.onAddButtonColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(bgColor!),
          foregroundColor: WidgetStatePropertyAll<Color>(fgColor!),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          elevation: WidgetStatePropertyAll(1),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: fgColor),
            const SizedBox(width: 8),
            Text(Localiza.find(textId)),
          ],
        ),
      ),
    );
  }
}
