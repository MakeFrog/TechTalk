import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';

const _greetings = [
  '좋은 결과 있기를 기도하겠습니다!',
  '노력한만큼 좋은 결과가 있을거에요!',
  '열심히 하는 모습이 보기 좋아요!',
];

String greetingToInterviewee(String nickname) {
  return '${tr(
    LocaleKeys.undefined_greetingMessage,
    namedArgs: {
      'nickname': nickname,
    },
  )} ${_greetings[Random().nextInt(2)]}';
}
