import 'dart:math';

import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/core/constants/assets.dart';

enum Interviewer {
  blueTilde('blueTilde', LocaleKeys.common_interviewersName_bitwiseNegation, Assets.characterBlue01),
  bluePlus('bluePlus', LocaleKeys.common_interviewersName_incrementOperation, Assets.characterBlue02),
  blueEqual('blueEqual', LocaleKeys.common_interviewersName_equalityOperation, Assets.characterBlue03),
  blueComment('blueComment', LocaleKeys.common_interviewersName_comment, Assets.characterBlue04),
  blueStar('blueStar', LocaleKeys.common_interviewersName_exponentiation, Assets.characterBlue05),
  blueString1('blueString1', LocaleKeys.common_interviewersName_string, Assets.characterBlue06),
  blueString2('blueString2', LocaleKeys.common_interviewersName_string, Assets.characterBlue07),

  greenTilde('greenTilde', LocaleKeys.common_interviewersName_bitwiseNegation, Assets.characterGreen01),
  greenPlus('greenPlus', LocaleKeys.common_interviewersName_incrementOperation, Assets.characterGreen02),
  greenEqual('greenEqual', LocaleKeys.common_interviewersName_equalityOperation, Assets.characterGreen03),
  greenComment('greenComment', LocaleKeys.common_interviewersName_comment, Assets.characterGreen04),
  greenStar('greenStar', LocaleKeys.common_interviewersName_exponentiation, Assets.characterGreen05),
  greenString1('greenString1', LocaleKeys.common_interviewersName_string, Assets.characterGreen06),
  greenString2('greenString2', LocaleKeys.common_interviewersName_string, Assets.characterGreen07),

  purpleTilde('purpleTilde', LocaleKeys.common_interviewersName_bitwiseNegation, Assets.characterPurple01),
  purplePlus('purplePlus', LocaleKeys.common_interviewersName_incrementOperation, Assets.characterPurple02),
  purpleEqual('purpleEqual', LocaleKeys.common_interviewersName_equalityOperation, Assets.characterPurple03),
  purpleComment('purpleComment', LocaleKeys.common_interviewersName_comment, Assets.characterPurple04),
  purpleStar('purpleStar', LocaleKeys.common_interviewersName_exponentiation, Assets.characterPurple05),
  purpleString1('purpleString1', LocaleKeys.common_interviewersName_string, Assets.characterPurple06),
  purpleString2('purpleString2', LocaleKeys.common_interviewersName_string, Assets.characterPurple07),

  redTilde('redTilde', LocaleKeys.common_interviewersName_bitwiseNegation, Assets.characterRed01),
  redPlus('redPlus', LocaleKeys.common_interviewersName_incrementOperation, Assets.characterRed02),
  redEqual('redEqual', LocaleKeys.common_interviewersName_equalityOperation, Assets.characterRed03),
  redComment('redComment', LocaleKeys.common_interviewersName_comment, Assets.characterRed04),
  redStar('redStar', LocaleKeys.common_interviewersName_exponentiation, Assets.characterRed05),
  redString1('redString1', LocaleKeys.common_interviewersName_string, Assets.characterRed06),
  redString2('redString2', LocaleKeys.common_interviewersName_string, Assets.characterRed07);

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
