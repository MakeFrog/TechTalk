import 'dart:math';

import 'package:techtalk/core/constants/assets.dart';

enum InterviewerEntity {
  bluePlus('bluePlus', '엄격한 면접관', Assets.characterBlue02),
  greenPlus('greenPlus', '너그러운 면접관', Assets.characterGreen02),
  purplePlus('purplePlus', '딱딱한 면접관', Assets.characterPurple02),
  redPlus('redPlus', '잘생긴 면접관', Assets.characterRed02);

  final String id;
  final String name;
  final String iconPath;

  const InterviewerEntity(this.id, this.name, this.iconPath);

  static InterviewerEntity getAvatarInfoById(String id) {
    return values.firstWhere(
      (avatar) => avatar.id == id,
      orElse: () => throw Exception('Unexpected Topic Id Value'),
    );
  }

  static InterviewerEntity getRandomInterviewer() {
    final totalCount = InterviewerEntity.values.length;
    return InterviewerEntity.values[Random().nextInt(totalCount)];
  }
}