import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    ref.read(mainBottomNavigationProvider.notifier).index = index;
  }
}
