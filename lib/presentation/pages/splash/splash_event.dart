import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/user/auth/is_user_authorized_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

mixin class SplashEvent {
  static bool initComplete = false;

  Future<void> initStaticData(WidgetRef ref) async {
    await topicRepository.initStaticData();
  }

  Future<void> routeByUserAuthAndData(WidgetRef ref) async {
    final isAuthorized = ref.read(isUserAuthorizedProvider);
    if (!isAuthorized) {
      const SignInRoute().go(ref.context);
      return;
    }

    await ref.read(userDataProvider.future).then(
      (userData) {
        if (userData == null) {
          const SignUpRoute().go(ref.context);
        } else {
          const MainRoute().go(ref.context);
        }
      },
    ).then((_) => initComplete = true);
  }
}
