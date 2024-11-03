import 'package:flutter/cupertino.dart';

part 'argument_holder_context_extension.dart';

///
/// 화면에 데이터를 전달하기 위한 InheritedWidget 클래스
/// 주어진 context를 통해 전달받은 argument 값을 접근할 수 있도록 제공
///
class ArgumentHolder extends InheritedWidget {
  final dynamic argument;

  const ArgumentHolder({
    required this.argument,
    super.key,
    required super.child,
  });

  static ArgumentHolder? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ArgumentHolder>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
