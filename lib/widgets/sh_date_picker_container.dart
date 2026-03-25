import 'package:flutter/material.dart';

import '../presentation_layer/validators/validators.dart';
import '../utils.dart';
import '../widgets.dart';

class ShDatePickerContainer extends StatefulWidget {
  final DateTime initDate;

  final ValueChanged<DateTime> onDateChanged;

  const ShDatePickerContainer({
    required this.initDate,
    required this.onDateChanged,
  });

  @override
  State<ShDatePickerContainer> createState() => _ShDatePickerContainerState();
}

class _ShDatePickerContainerState extends State<ShDatePickerContainer> {
  late DateTime _date;

  @override
  void initState() {
    _date = widget.initDate;
    super.initState();
  }

  Future<void> selectDate(BuildContext context) async {
    final date = await DialogHelper.showDateDialog(
      context: context,
      initDate: _date,
    );

    if (date != null && date != _date) {
      setState(() => _date = date);
      widget.onDateChanged(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final colors = context.colors;

    return LabelFormField<String>(
      label: findText("admissao"),
      themeColor: colors.primary,
      initialValue: formatDateByLocale(_date, locale),
      valueFormatter: (s) => s,
      icon: Icons.calendar_month,
      onTap: () => selectDate(context),
      validator: (s) {
        return DateValidator.validate(
          _date,
          "dataVazia",
          "dataInvalida",
        );
      },
    );
  }
}
