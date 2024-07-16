import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/index.dart';

part 'main_bottom_navigation_provider.g.dart';

enum MainNavigationTab {
  home('gnb.home', Assets.iconsHome),
  study('gnb.learning', Assets.iconsStudy),
  note('gnb.mistakeNote', Assets.iconsNote),
  myInfo('gnb.myInfo', Assets.iconsUser);

  final String jsonKey;
  final String iconPath;

  const MainNavigationTab(
    this.jsonKey,
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
