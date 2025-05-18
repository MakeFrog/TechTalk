import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';

part 'main_bottom_navigation_provider.g.dart';

enum MainNavigationTab {
  home('gnb.home', Assets.iconsHome),
  blog('gnb.blog', Assets.iconsBlog),
  youtube('gnb.videoTutorial', Assets.iconsVideoStudy),
  study('gnb.learning', Assets.iconsStudy),
  myInfo('gnb.myInfo', Assets.iconsUser);

  final String jsonKey;
  final String iconPath;

  const MainNavigationTab(
    this.jsonKey,
    this.iconPath,
  );

  static List<MainNavigationTab> get visibleTabs => [
        home,
        if (AppLocale.isKo) blog,
        youtube,
        study,
        myInfo,
      ];
}

@Riverpod(keepAlive: true)
class MainBottomNavigation extends _$MainBottomNavigation {
  @override
  MainNavigationTab build() {
    return MainNavigationTab.home;
  }

  void changeTab(MainNavigationTab value) {
    if (value == state) return;
    state = value;
  }
}
