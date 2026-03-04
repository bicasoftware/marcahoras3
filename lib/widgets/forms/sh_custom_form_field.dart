import 'package:flutter/material.dart';

import '../../utils.dart';

class ShCustomFormField<T> extends FormField<T> {
  ShCustomFormField({
    required Widget child,
    super.key,
    super.validator,
    super.autovalidateMode,
  }) : super(
         builder: (state) {
           return Column(
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
           );
         },
       );
}
