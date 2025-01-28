import 'package:flutter/material.dart';

class DualActionButton extends StatelessWidget {
  final Widget firstLabel, secondLabel;
  final Icon firstIcon, secondIcon;
  final VoidCallback onFirstTap, onSecondTap;
  final Color firstColor, secondColor;
  final String? firstHeroTag, secondHeroTag;

  const DualActionButton({
    required this.firstLabel,
    required this.firstIcon,
    required this.firstColor,
    required this.onFirstTap,
    required this.secondLabel,
    required this.secondIcon,
    required this.secondColor,
    required this.onSecondTap,
    this.firstHeroTag,
    this.secondHeroTag,
  });

  List<BoxShadow> get shadow => [
        BoxShadow(
          color: Colors.black12,
          blurRadius: .2,
          offset: Offset(.5, 1),
          spreadRadius: .3,
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: "$firstHeroTag",
            child: Container(
              decoration: BoxDecoration(
                color: firstColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  topLeft: Radius.circular(32),
                ),
                boxShadow: shadow,
              ),
              child: TextButton.icon(
                label: firstLabel,
                icon: firstIcon,
                onPressed: onFirstTap,
              ),
            ),
          ),
          VerticalDivider(
            width: .5,
          ),
          Hero(
            tag: "$secondHeroTag",
            child: Container(
              decoration: BoxDecoration(
                color: secondColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: shadow,
              ),
              child: TextButton.icon(
                label: secondLabel,
                icon: secondIcon,
                onPressed: onSecondTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
