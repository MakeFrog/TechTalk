///
/// boolean 비교 연산자를 간편하고
/// 직관적으로 관리할 수 있도록 도와주는 extension
///

extension BoolExtension on bool {
  bool get isTrue => this == true;

  bool get isFalse => this == false;
}
