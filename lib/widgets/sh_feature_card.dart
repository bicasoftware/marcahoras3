import 'package:flutter/material.dart';

import '../utils.dart';
import '../widgets.dart';

class ShFeatureCard extends StatelessWidget {
  final bool hasData, isOutlined;
  final String noDataLabelId, noDataExtraLabelId;
  final IconData noDataIcon;

  final String cardLabelId;
  final String seeMoreLabelId;
  final Widget child;

  final VoidCallback onSeeMoreTap, noDataTap;

  const ShFeatureCard({
    required this.child,
    required this.hasData,
    required this.isOutlined,
    required this.noDataLabelId,
    required this.noDataExtraLabelId,
    required this.onSeeMoreTap,
    required this.noDataIcon,
    required this.noDataTap,
    required this.cardLabelId,
    required this.seeMoreLabelId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    return OutlinedCard(
      margin: .all(8),
      cardColor: colors.surface,
      outlineColor: isOutlined ? null : Colors.transparent,
      child: hasData
          ? Column(
              children: [
                Container(
                  padding: .only(left: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ShText(
                          cardLabelId,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: .bold,
                            color: colors.onSurface,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        label: ShText(seeMoreLabelId),
                        iconAlignment: .end,
                        icon: Icon(Icons.keyboard_arrow_right_outlined),
                        onPressed: onSeeMoreTap,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: .only(bottom: 8),
                  child: Divider(
                    color: colors.primary.withAlpha(80),
                    radius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    height: 1,
                    indent: 8,
                    endIndent: 8,
                  ),
                ),
                Expanded(child: child),
              ],
            )
          : Expanded(
              child: Center(
                child: IntrinsicHeight(
                  child: OutlinedCard(
                    margin: .all(8),
                    cardColor: colors.surface,
                    child: ShEmptyListItem(
                      descriptionId: noDataLabelId,
                      extraDescriptionId: noDataExtraLabelId,
                      icon: noDataIcon,
                      onAddTap: noDataTap,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
