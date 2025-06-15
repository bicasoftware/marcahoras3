import 'package:flutter/material.dart';

class ShOutlinedButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const ShOutlinedButton({
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(
            color: color,
            width: 1.0,
            style: BorderStyle.solid,
            strokeAlign: 1            
        ),        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        )
      ),      
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
      ),
      onPressed: onTap,
    );
  }
}
