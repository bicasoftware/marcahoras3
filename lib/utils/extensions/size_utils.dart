import 'package:flutter/material.dart';

extension SizeHelper on BuildContext {
  Size get size => MediaQuery.of(this).size;

  double getHeightByPercent(int percent) {
    return size.height * (100/percent);
  }
  
  double getWidthByPercent(int percent) {
    return size.width * (100/percent);
  }
}
