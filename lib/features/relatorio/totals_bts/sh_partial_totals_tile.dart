import 'package:flutter/material.dart';

import '../../../utils.dart';
import '../../../widgets.dart';

class ShParcialTotalsTile extends StatelessWidget {
  final String labelId;
  final double amount;
  final int workedMinutes, totalWorkedMinutes, percent;
  final Color themeColor;

  const ShParcialTotalsTile({
    required this.labelId,
    required this.amount,
    required this.workedMinutes,
    required this.totalWorkedMinutes,
    required this.percent,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: Material(
            color: themeColor.withAlpha(80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const .all(8.0),
              child: Icon(Icons.av_timer),
            ),
          ),

          trailing: Column(
            mainAxisSize: .min,
            mainAxisAlignment: .end,
            crossAxisAlignment: .end,
            children: [
              Text(
                CurrencyHelper.formatAmount(amount),
                textAlign: .end,
              ),
              Text(
                "${TimeOfDayHelper.formatTimeFromMinutes(workedMinutes)} hrs",
                textAlign: .end,
              ),
            ],
          ),

          title: ShText(
            labelId,
            softWrap: true,
            overflow: .ellipsis,                        
          ),
          subtitle: Text("$percent %"),
        ),
        Padding(
          padding: const .symmetric(horizontal: 16.0),
          child: LinearProgressIndicator(
            value: (workedMinutes / totalWorkedMinutes),
            valueColor: AlwaysStoppedAnimation<Color>(themeColor),
            backgroundColor: themeColor.withAlpha(80),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ],
    );
  }
}
