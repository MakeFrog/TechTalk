import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/user/models/user_data_model.dart';
import 'package:techtalk/features/user/usecases/get_user_data_use_case.dart';
import 'package:techtalk/presentation/providers/app_user_auth_provider.dart';

part 'app_user_data_provider.g.dart';

@riverpod
class AppUserData extends _$AppUserData {
  @override
  FutureOr<UserDataModel?> build() async {
    final userAuth = ref.watch(appUserAuthProvider);

    if (userAuth == null) return null;

    final userData = await getUserDataUseCase(userAuth.uid);

    return userData;
  }
}
