import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/presentation/providers/user/user_auth_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

abstract interface class _SplashEvent {
  Future<void> routeByUserAuthAndData(WidgetRef ref);
}

mixin class SplashEvent implements _SplashEvent {
  @override
  Future<void> routeByUserAuthAndData(WidgetRef ref) async {
    final isLoggedIn = ref.read(isUserAuthorizedProvider);

    if (!isLoggedIn) {
      const SignInRoute().go(ref.context);
      return;
    }

    await ref.read(userDataProvider.future).then(
      (userData) {
        if (userData != null) {
          const MainRoute().go(ref.context);
        } else {
          const SignInRoute().go(ref.context);
        }
      },
    );
  }
}
