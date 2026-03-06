import 'package:flutter/material.dart';

import '../../utils.dart';
import '../../widgets.dart';

class ShDropdownTile<T> extends StatelessWidget {
  final String labelId;
  final IconData icon;
  final T selectedItem;
  final List<T> items;
  final String? Function(String?)? validator;
  final String Function(T item) formatItem;
  final ValueChanged<T?>? onItemChanged;
  final EdgeInsets? padding;

  final Color themeColor;

  const ShDropdownTile({
    required this.labelId,
    required this.themeColor,
    required this.icon,
    required this.selectedItem,
    required this.items,
    required this.formatItem,
    this.validator,
    this.onItemChanged,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ShFormItem(
      labelId: labelId,
      icon: icon,
      themeColor: themeColor,
      child: Padding(
        padding: .symmetric(horizontal: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            isExpanded: true,
            value: selectedItem,
            focusColor: colors.onPrimary,
            items: items
                .map(
                  (e) => DropdownMenuItem<T>(
                    value: e,                    
                    child: Container(
                      margin: .only(right: 8),
                      child: ShFormLabel.subtitle(formatItem(e))  
                    ),
                  ),
                )
                .toList(),

            onChanged: onItemChanged,
          ),
        ),
      ),
    );
  }
}
