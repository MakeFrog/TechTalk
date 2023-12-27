import 'package:flutter/material.dart';
import 'package:techtalk/app/router/router.dart';

class DialogService {
  DialogService._();

  static void show({
    required Dialog dialog,
  }) {
    showDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (_) => dialog,
    );
  }
}
