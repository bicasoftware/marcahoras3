import 'package:flutter/material.dart';

import '../../dialogs.dart';

class DialogHelper {
  static Future<DateTime?> showDateDialog({
    required BuildContext context,
    required DateTime initDate,
    DateTime? endDate,
    DateTime? admissao,
    bool allowFutureDates = false,
  }) async {
    final date = await showPopupNumberPickerBts(
      context: context,
      titleMsg: 'selecionarData',
      formatValue: (values) {
        final vals = values.map(int.parse).toList();
        return DateTime(vals[2], vals[1], vals[0]);
      },
      fields: [
        NumberFieldDef(
          maxLength: 2,
          label: "dia",
          min: 1,
          max: 31,
          initialValue: initDate.day,
        ),
        NumberFieldDef(
          maxLength: 2,
          label: "mes",
          min: 1,
          max: 12,
          initialValue: initDate.month,
        ),
        NumberFieldDef(
          maxLength: 4,
          label: "ano",
          min: 2020,
          max: 2035,
          initialValue: initDate.year,
        ),
      ],
    );

    return (date != null && date != initDate) ? date : null;
  }

  static Future<TimeOfDay?> showTimePickerDialog({
    required BuildContext context,
    required TimeOfDay time,
  }) async {
    return await showPopupNumberPickerBts(
      context: context,
      titleMsg: 'selecionarHorario',
      formatValue: (values) {
        final vals = values.map(int.parse).toList();
        return TimeOfDay(hour: vals[0], minute: vals[1]);
      },
      fields: [
        NumberFieldDef(
          maxLength: 2,
          label: "hora",
          min: 0,
          max: 23,
          initialValue: time.hour,
        ),
        NumberFieldDef(
          maxLength: 2,
          label: "minuto",
          min: 0,
          max: 59,
          step: 5,
          initialValue: time.minute,
        ),
      ],
    );
  }
}
