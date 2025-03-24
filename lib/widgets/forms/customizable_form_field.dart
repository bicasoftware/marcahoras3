import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets.dart';

import '../../resources.dart';

class CustomizableFormField<T> extends FormField<T> {
  CustomizableFormField({
    required String label,
    required Widget child,
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
               spacing: 4,
               children: [
                 child,
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
