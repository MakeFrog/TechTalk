extension StringValidationExt on String {
  // 공백 존재 여부
  bool get hasSpace {
    return RegExp(r'\s').hasMatch(this);
  }

  bool get hasProperLength {
    return trim().length < 2 || trim().length > 10;
  }

  /// 적합한 문자 사용 여부
  /// 한글, 알파벳, 숫자, 언더스코어(_), 하이픈(-)만 사용할 수 있음
  bool get hasProperCharacter {
    return !RegExp(r'^[a-zA-Z0-9ㄱ-ㅎ가-힣_-]+$').hasMatch(trim());
  }

  // Operation 글자 포함 여부
  bool get hasContainOperationWord {
    return RegExp('운영자|관리자|테크톡|TechTalk|techtalk').hasMatch(trim());
  }
}
