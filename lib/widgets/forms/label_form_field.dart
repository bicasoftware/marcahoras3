import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets.dart';

import '../../resources.dart';

class LabelFormField<T> extends FormField<T> {
  LabelFormField({
    required String label,
    required T initialValue,
    required String Function(T) valueFormatter,
    IconData? icon,
    EdgeInsets? padding,
    Widget? trailing,
    required VoidCallback onTap,
    super.key,
    super.validator,
    super.autovalidateMode,
  }) : super(
         builder: (state) {
           final theme = Theme.of(state.context).textTheme;
           return IndicatorTile(
             onTap: onTap,
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                 ListTile(
                   title: Text(label, style: theme.labelLarge),
                   leading: Icon(icon),
                   contentPadding: padding,
                   trailing: trailing,
                   subtitle: Text(valueFormatter(initialValue)),
                 ),
                 state.hasError
                     ? Container(
                       margin: EdgeInsets.only(top: 8, bottom: 8, left: 56),                       
                       child: Text(
                         state.errorText!,
                         style: theme.labelMedium!.copyWith(
                           color: AppColors.error,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     )
                     : const SizedBox.shrink(),
               ],
             ),
           );
         },
       );
}
