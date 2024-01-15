import 'dart:math';

const _greetings = [
  '좋은 결과 있기를 기도하겠습니다!',
  '노력한만큼 좋은 결과가 있을거에요!',
  '열심히 하는 모습이 보기 좋아요!',
];

String greetingToInterviewee(String nickname) {
  return '반가워요! $nickname님. ${_greetings[Random().nextInt(2)]}';
}
