import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

extension MessagesUtils on BuildContext {
  void showSnackBar(BuildContext ctx, String msg) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: Theme.of(this).textTheme.labelLarge,
        ),
        elevation: 2,
        backgroundColor: Theme.of(ctx).colorScheme.onPrimary,
      ),
    );
  }

  void showFloatingMessage(String msg, [MessageType? messageType]) {
    toastification.show(
      context: this,
      title: Text(msg),
      autoCloseDuration: Duration(seconds: 10),
      style: ToastificationStyle.minimal,
      alignment: Alignment.bottomRight,
      pauseOnHover: true,
      type: messageType?.toastType ?? ToastificationType.info,
    );
  }
}

enum MessageType {
  success(ToastificationType.success),
  error(ToastificationType.error),
  warning(ToastificationType.warning),
  neutral(ToastificationType.info)
  ;

  final ToastificationType toastType;

  const MessageType(this.toastType);
}
