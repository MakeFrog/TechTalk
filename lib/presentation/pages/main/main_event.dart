import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/main_navigation_tab.enum.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';

abstract interface class _MainEvent {
  void onTapBottomNavigationItem(
    WidgetRef ref, {
    required int index,
  });
}

mixin class MainEvent implements _MainEvent {
  @override
  void onTapBottomNavigationItem(
    WidgetRef ref, {
    required int index,
  }) {
    ref.read(mainBottomNavigationProvider.notifier).tab =
        MainNavigationTab.values[index];
  }
}
