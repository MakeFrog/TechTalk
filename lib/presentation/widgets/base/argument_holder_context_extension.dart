part of 'route_argument.dart';

///
/// BuildContext에 argument 값을 쉽게 가져올 수 있는 확장 메서드를 추가
/// ArgumentHolder 위젯에서 전달된 값을 가져와 타입에 맞게 반환
///
extension ArgumentHolderContextExt on BuildContext {
  T getArgument<T>() {
    try {
      final argument = ArgumentHolder.maybeOf(this)?.argument;
      return argument;
    } catch (e) {
      throw Exception('잘못된 인자값 입니다 : $e');
    }
  }
}
