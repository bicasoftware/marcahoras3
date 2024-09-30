import 'package:flutter/material.dart';

import '../../../../resources.dart';
import '../../../../widgets/bottomsheets/bottomsheethelper.dart';

class CalendarDateNavigator extends StatelessWidget
    implements PreferredSizeWidget {
  final int year;
  final int month;
  final VoidCallback onMonthAdd, onMonthDec;
  final void Function(int year) onYearChanged, onMonthChanged;

  const CalendarDateNavigator({
    required this.year,
    required this.month,
    required this.onMonthAdd,
    required this.onMonthDec,
    required this.onYearChanged,
    required this.onMonthChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final strings = context.strings();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.inversePrimary,
      child: Row(children: [
        Expanded(
          flex: 2,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.onPrimary,
              size: 16,
            ),
            onPressed: onMonthDec,
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: Text(
                strings.months[month-1],
                style: theme.bodyLarge?.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
              onPressed: () async {
                BottomSheetHelper.showModalBts(
                  context: context,
                  body: Container(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 3.1,
                        children: strings.months.map(
                          (m) {
                            return GestureDetector(
                              onTap: () {
                                onMonthChanged(strings.months.indexOf(m));
                                print(strings.months.indexOf(m));
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.all(
                                  8,
                                ),
                                child: Text(m, textAlign: TextAlign.justify),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            alignment: Alignment.centerLeft,
            child: TextButton(
              child: Text(
                "$year",
                style: theme.bodyLarge?.copyWith(
                  color: AppColors.onPrimary,
                ),
                textAlign: TextAlign.end,
              ),
              onPressed: () async {
                BottomSheetHelper.showModalBts(
                  context: context,
                  body: Container(
                    height: 230,
                    child: YearPicker(
                      firstDate: DateTime(2010, 01, 01),
                      lastDate: DateTime.now(),
                      selectedDate: DateTime(year, month, 1),
                      onChanged: (value) {
                        onYearChanged(value.year);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.onPrimary,
              size: 16,
            ),
            onPressed: onMonthAdd,
          ),
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
