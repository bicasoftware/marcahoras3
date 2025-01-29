import 'package:flutter/material.dart';

class DualActionButton extends StatelessWidget {
  final Widget firstLabel, secondLabel;
  final Icon firstIcon, secondIcon;
  final VoidCallback onFirstTap, onSecondTap;
  final Color firstColor, secondColor;
  final String? firstHeroTag, secondHeroTag;
  final EdgeInsets padding;

  const DualActionButton({
    required this.firstLabel,
    required this.firstIcon,
    required this.firstColor,
    required this.onFirstTap,
    required this.secondLabel,
    required this.secondIcon,
    required this.secondColor,
    required this.onSecondTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.firstHeroTag,
    this.secondHeroTag,
  });

  List<BoxShadow> get shadow => [
        BoxShadow(
          color: Colors.black26,
          blurRadius: .5,
          offset: Offset(.8, .8),
          spreadRadius: .5,
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Hero(
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
          ),
          VerticalDivider(
            width: 1,
          ),
          Expanded(
            child: Hero(
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
          ),
        ],
      ),
    );
  }
}
