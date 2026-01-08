import 'package:flutter/material.dart';

import '../../utils.dart';
import '../../widgets.dart';

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
                           style: state.context.textTheme.labelMedium!.copyWith(
                             color: state.context.colors.error,
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
