import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils.dart';
import '../widgets.dart';

class NoDataContainer extends StatelessWidget {
  final String labelId, extraLabelId;
  final String? helperButtonLabel;
  final void Function() helperButtonTap;

  const NoDataContainer({
    required this.labelId,
    required this.extraLabelId,
    required this.helperButtonTap,
    this.helperButtonLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final colors = context.colors;

    return Center(
      child: IntrinsicHeight(
        child: OutlinedCard(
          margin: .all(8),
          cardColor: colors.surface,
          child: ShEmptyListItem(
            descriptionId: labelId,
            extraDescriptionId: extraLabelId,
            addButtonLabel: helperButtonLabel,
            icon: FontAwesomeIcons.addressCard,              
            onAddTap: helperButtonTap,
          ),
        ),
      ),
    );
  }
}
