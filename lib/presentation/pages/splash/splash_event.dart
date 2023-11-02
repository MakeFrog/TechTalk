import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';
import 'package:techtalk/presentation/providers/app_user_data_provider.dart';

abstract interface class _SplashEvent {
  Future<void> initUserAuthAndData(WidgetRef ref);
}

mixin class SplashEvent implements _SplashEvent {
  @override
  Future<void> initUserAuthAndData(WidgetRef ref) async {
    final isLoggedIn = ref.read(isUserAuthorizedProvider);

    if (!isLoggedIn) {
      const SignInRoute().go(ref.context);
    } else {
      await ref
          .read(
        appUserDataProvider.selectAsync((data) => data != null),
      )
          .then((hasUserData) {
        if (hasUserData) {
          const MainRoute().go(ref.context);
        } else {
          const SignUpRoute().go(ref.context);
        }
      });
    }
  }
}
