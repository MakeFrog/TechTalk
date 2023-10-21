import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/main_navigation_tab.enum.dart';

part 'main_bottom_navigation_provider.g.dart';

@Riverpod(keepAlive: true)
class MainBottomNavigation extends _$MainBottomNavigation {
  @override
  MainNavigationTab build() {
    return MainNavigationTab.home;
  }

  set tab(MainNavigationTab value) => state = value;
}
