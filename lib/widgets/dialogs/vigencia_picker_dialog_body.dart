import 'package:flutter/material.dart';

import '../../resources.dart';
import '../../utils.dart';
import '../../widgets.dart';

class VigenciaPickerBody extends StatefulWidget {
  final int ano, mes;
  final Function((int, int) vigencia) onVigenciaSet;

  const VigenciaPickerBody({
    super.key,
    required this.mes,
    required this.ano,
    required this.onVigenciaSet,
  });

  @override
  State<VigenciaPickerBody> createState() => _VigenciaPickerBodyState();
}

class _VigenciaPickerBodyState extends State<VigenciaPickerBody> {
  int _yearPos = 0, _monthPos = 0;
  late final List<int> yearList;
  final months = Localiza.findList("monthsAbrev");
  final monthList = List.generate(12, (i) => i );

  @override
  void initState() {
    final currentYear = DateTime.now().year;
    final startYear = 2018;
    final endYear = currentYear + 2;
    yearList = List<int>.generate(endYear - startYear, (i) => startYear + i);

    _yearPos = yearList.indexWhere((y) => y == widget.ano);
    _monthPos = widget.mes - 1;
    super.initState();
  }

  (int, int) getVigencia() => (yearList[_yearPos], _monthPos + 1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey[50],
                        child: ShScrollablePicker<int>(
                          items: yearList,
                          selectedItem: yearList[_yearPos],
                          valueFormatter: <int>(i) => "$i",
                          onItemSelected: (int pos) {
                            setState(() => _yearPos = pos);
                            widget.onVigenciaSet(getVigencia());
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: Text(
                          ":",
                          style: theme.bodyLarge!.copyWith(fontSize: 40),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey[50],
                        child: ShScrollablePicker<int>(
                          items: monthList,
                          selectedItem: monthList[_monthPos],
                          valueFormatter: <int>(i) => months[i],
                          onItemSelected: (int pos) {
                            setState(() => _monthPos = pos);
                            widget.onVigenciaSet(getVigencia());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      Localiza.find('ano'),
                      textAlign: TextAlign.start,
                      style: theme.labelLarge!.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      Localiza.find('mes'),
                      textAlign: TextAlign.start,
                      style: theme.labelLarge!.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
