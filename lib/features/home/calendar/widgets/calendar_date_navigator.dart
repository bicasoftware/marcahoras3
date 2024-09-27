import 'package:flutter/material.dart';

import '../../../../resources.dart';

class CalendarDateNavigator extends StatelessWidget
    implements PreferredSizeWidget {
  final int year;
  final int month;

  const CalendarDateNavigator({
    required this.year,
    required this.month,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.inversePrimary,
      child: Row(children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.onPrimary,
            size: 16,
          ),
          onPressed: () {},
        ),
        Expanded(
          child: TextButton.icon(
            iconAlignment: IconAlignment.end,
            icon: Icon(
              Icons.calendar_today,
              color: AppColors.onPrimary,
              size: 16,
            ),
            label: Text(
              "$year",
              style: theme.bodyLarge?.copyWith(
                color: AppColors.onPrimary,
              ),
            ),
            onPressed: () {},
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.onPrimary,
            size: 16,
          ),
          onPressed: () {},
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
