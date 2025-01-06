import 'package:flutter/material.dart';

import '../../../resources.dart';
import '../../../utils/utils.dart';
import '../../../widgets.dart';

class PresentationEmpregoAdmissao extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onDateChanged;

  const PresentationEmpregoAdmissao({
    required this.date,
    required this.onDateChanged,
    super.key,
  });

  @override
  State<PresentationEmpregoAdmissao> createState() =>
      _PresentationEmpregoAdmissaoState();
}

class _PresentationEmpregoAdmissaoState
    extends State<PresentationEmpregoAdmissao> {
  late DateTime currentDate;

  @override
  void initState() {
    currentDate = widget.date;
    super.initState();
  }

  Future<void> _selectDate(
    BuildContext context,
  ) async {
    final newDate = await DialogHelper.showDateTimeDialog(
      context,
      currentDate,
    );

    if (newDate != null && newDate != currentDate) {
      widget.onDateChanged(newDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final locale = Localizations.localeOf(context);

    return ShLabeledTile(
      value: formatDateByLocale(widget.date, locale),
      label: strings.admissao,
      onTap: () => _selectDate(context),
      icon: Icons.calendar_month,
    );
  }
}
