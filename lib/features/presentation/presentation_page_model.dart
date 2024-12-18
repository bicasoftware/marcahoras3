import 'package:flutter/widgets.dart';

class PresentationPageModel {
  final String title, message, image;
  final Widget child;

  PresentationPageModel({
    required this.title,
    required this.message,
    required this.image,
    required this.child,
  });
}
