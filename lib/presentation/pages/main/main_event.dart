import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';

mixin class MainEvent {
  void onTapBottomNavigationItem(
    WidgetRef ref, {
    required int index,
  }) {
    ref.read(mainBottomNavigationProvider.notifier).tab =
        MainNavigationTab.values[index];
  }
}
