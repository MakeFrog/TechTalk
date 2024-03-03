import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/index.dart';

part 'main_bottom_navigation_provider.g.dart';

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

@Riverpod(keepAlive: true)
class MainBottomNavigation extends _$MainBottomNavigation {
  @override
  MainNavigationTab build() {
    return MainNavigationTab.home;
  }

  set tab(MainNavigationTab value) => state = value;
}
