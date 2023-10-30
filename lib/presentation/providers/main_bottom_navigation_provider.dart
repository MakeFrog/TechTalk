import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_bottom_navigation_provider.g.dart';

@Riverpod(keepAlive: true)
class MainBottomNavigation extends _$MainBottomNavigation {
  @override
  int build() {
    return 0;
  }

  set index(int value) => state = value;
}
