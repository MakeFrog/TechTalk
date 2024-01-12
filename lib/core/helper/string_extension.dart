import 'dart:async';

import 'package:rxdart/subjects.dart';

extension StringExtensions on String {
  ///
  /// 두 개 이상의 문자열을 포함하는지 확인하는 메소드
  ///
  bool containsMultiple(List<String> substrings) {
    return substrings.any(contains);
  }

  ///
  /// 문자열을 Stream형태로 변환해주는 메소드
  ///
  /// NOTE:
  /// '실시간으로 입력되는 효과'를 주기 위해 일정한 시간마다 한 글자씩 Stream 값을 더하는 로직이 존재
  ///
  BehaviorSubject<String> get convertToStreamText {
    final BehaviorSubject<String> messageSubject = BehaviorSubject<String>();
    int index = 0;

    Timer.periodic(
      const Duration(milliseconds: 20),
      (timer) {
        if (index < length) {
          messageSubject.add(substring(0, index + 1));
          index++;
        } else {
          timer.cancel();
          messageSubject.close();
        }
      },
    );

    return messageSubject;
  }

  ///
  /// 검색일치 여부를 확인하기 위한
  /// 정제된 문자열로 변환하는 메소드
  ///
  String get toSearchableStr => replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), '')
      .toLowerCase();


  ///
  /// 한국어 포함 여부
  ///
  bool get containsKorean {
    RegExp koreanRegExp = RegExp(r'[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]');

    return koreanRegExp.hasMatch(this);
  }

  ///
  /// 문자열의 첫 번째 글자가 영어로 시작하는지 여부
  ///
  bool get startsWithEnglish {
    if (isEmpty) {
      return false;
    }

    int firstCharCode = codeUnitAt(0);
    return (firstCharCode >= 65 && firstCharCode <= 90) ||
        (firstCharCode >= 97 && firstCharCode <= 122);
  }
}
