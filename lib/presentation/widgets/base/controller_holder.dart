import 'package:flutter/material.dart';

class ControllerHolder<T> extends InheritedWidget {
  final T controller;

  const ControllerHolder({
    required this.controller,
    super.key,
    required super.child,
  });

  static ControllerHolder<T>? maybeOf<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ControllerHolder<T>>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

extension ControllerHolderContextExt on BuildContext {
  T getController<T>() {
    final argument = ControllerHolder.maybeOf<T>(this)?.controller;
    if (argument == null) {
      throw Exception('잘못된 컨트롤러 값 입니다');
    }
    return argument;
  }
}
