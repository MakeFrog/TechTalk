import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';

part 'app_user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class AppUserData extends _$AppUserData {
  @override
  FutureOr<UserDataEntity?> build() async {
    final userAuth = ref.watch(appUserAuthProvider);

    if (userAuth == null) return null;

    final userData = await getUserDataUseCase(userAuth.uid);

    return userData;
  }

  void updateUserData() {}
}
