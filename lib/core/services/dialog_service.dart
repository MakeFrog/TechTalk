import 'package:flutter/material.dart';
import 'package:techtalk/app/router/router.dart';

class DialogService {
  DialogService._();

  static void show({
    required Dialog dialog,
     bool? dismissible,
  }) {
    showDialog(
      barrierDismissible: dismissible ?? true,
      context: rootNavigatorKey.currentContext!,
      builder: (_) => dialog,
    );
  }

  static Future<void> asyncShow({
    required Dialog dialog,
     bool? dismissible,
  }) {
    return Future.value(
      showDialog(
        barrierDismissible: dismissible ?? true,
        context: rootNavigatorKey.currentContext!,
        builder: (_) => dialog,
      ),
    );
  }
}
