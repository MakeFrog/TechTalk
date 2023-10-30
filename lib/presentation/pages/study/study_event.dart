import 'package:flutter/material.dart';

abstract interface class _StudyEvent {
  void onToggleBlurAnswer(bool value, ValueNotifier<bool> notifier);
}

mixin class StudyEvent implements _StudyEvent {
  @override
  void onToggleBlurAnswer(bool value, ValueNotifier<bool> notifier) {
    notifier.value = value;
  }
}
