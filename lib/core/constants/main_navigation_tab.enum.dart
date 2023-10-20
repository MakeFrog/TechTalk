import 'package:techtalk/core/core.dart';

enum MainNavigationTab {
  home('홈', Assets.iconsHome),
  study('학습', Assets.iconsStudy),
  note('오답노트', Assets.iconsNote),
  myInfo('내 정보', Assets.iconsUser);

  final String label;
  final String iconPath;

  const MainNavigationTab(
    this.label,
    this.iconPath,
  );
}
