import 'package:flutter/material.dart';

class ShElevatedButton extends StatelessWidget {
  final Color color, iconColor;
  final IconData icon;
  final VoidCallback onTap;
  final String? label;

  const ShElevatedButton({
    required this.color,
    required this.iconColor,
    required this.icon,
    required this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: .5,
            blurRadius: 2,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          elevation: 1,
          shadowColor: Colors.black12,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
              if (label != null)
                Text(
                  label!,
                  style: theme.labelLarge?.copyWith(color: iconColor),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
            ],
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}
