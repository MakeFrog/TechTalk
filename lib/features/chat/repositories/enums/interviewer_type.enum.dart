import 'dart:math';

import 'package:techtalk/core/constants/assets.dart';

enum Interviewer {
  blueTilde('blueTilde', '비트 단위 부정 면접관', Assets.characterBlue01),
  bluePlus('bluePlus', '증가 연산 면접관', Assets.characterBlue02),
  blueEqual('blueEqual', '동등 연산 면접관', Assets.characterBlue03),
  blueComment('blueComment', '주석 면접관', Assets.characterBlue04),
  blueStar('blueStar', '거듭제곱 면접관', Assets.characterBlue05),
  blueString1('blueString1', '문자열 면접관', Assets.characterBlue06),
  blueString2('blueString2', '문자열 면접관', Assets.characterBlue07),

  greenTilde('greenTilde', '비트 단위 부정 면접관', Assets.characterGreen01),
  greenPlus('greenPlus', '증가 연산 면접관', Assets.characterGreen02),
  greenEqual('greenEqual', '동등 연산 면접관', Assets.characterGreen03),
  greenComment('greenComment', '주석 면접관', Assets.characterGreen04),
  greenStar('greenStar', '거듭제곱 면접관', Assets.characterGreen05),
  greenString1('greenString1', '문자열 면접관', Assets.characterGreen06),
  greenString2('greenString2', '문자열 면접관', Assets.characterGreen07),

  purpleTilde('purpleTilde', '비트 단위 부정 면접관', Assets.characterPurple01),
  purplePlus('purplePlus', '증가 연산 면접관', Assets.characterPurple02),
  purpleEqual('purpleEqual', '동등 연산자 면접관', Assets.characterPurple03),
  purpleComment('purpleComment', '주석 면접관', Assets.characterPurple04),
  purpleStar('purpleStar', '거듭제곱 면접관', Assets.characterPurple05),
  purpleString1('purpleString1', '문자열 면접관', Assets.characterPurple06),
  purpleString2('purpleString2', '문자열 면접관', Assets.characterPurple07),

  redTilde('redTilde', '비트 단위 부정 면접관', Assets.characterRed01),
  redPlus('redPlus', '증가 연산 면접관', Assets.characterRed02),
  redEqual('redEqual', '동등 연산 면접관', Assets.characterRed03),
  redComment('redComment', '주석 면접관', Assets.characterRed04),
  redStar('redStar', '거듭제곱 면접관', Assets.characterRed05),
  redString1('redString1', '문자열 면접관', Assets.characterRed06),
  redString2('redString2', '문자열 면접관', Assets.characterRed07);

  final String id;
  final String name;
  final String iconPath;

  const Interviewer(this.id, this.name, this.iconPath);

  static Interviewer getAvatarInfoById(String id) {
    return values.firstWhere(
      (avatar) => avatar.id == id,
      orElse: () => throw Exception('Unexpected Topic Id Value'),
    );
  }

  static Interviewer getRandomInterviewer() {
    final totalCount = Interviewer.values.length;
    return Interviewer.values[Random().nextInt(totalCount)];
  }
}
