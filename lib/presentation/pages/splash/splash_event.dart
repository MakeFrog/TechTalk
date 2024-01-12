import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/providers/user/auth/is_user_authorized_provider.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

abstract interface class _SplashEvent {
  Future<void> initStaticData(WidgetRef ref);

  Future<void> routeByUserAuthAndData(WidgetRef ref);
}

mixin class SplashEvent implements _SplashEvent {
  static bool initComplete = false;

  @override
  Future<void> initStaticData(WidgetRef ref) async {
    await Future.wait([
      techSetRepository.initStaticData(),
      techSetRepository.initSkills(),
    ]);

    await topicRepository.initStaticData();
  }

  @override
  Future<void> routeByUserAuthAndData(WidgetRef ref) async {
    final isAuthorized = ref.read(isUserAuthorizedProvider);
    if (!isAuthorized) {
      const SignInRoute().go(ref.context);
      return;
    }

    await ref.read(userDataProvider.future).then(
      (userData) {
        if (userData == null || !userData.hasEssentialData) {
          const SignInRoute().go(ref.context);
        } else {
          const MainRoute().go(ref.context);
        }
      },
    ).then((_) => initComplete = true);
  }
}
