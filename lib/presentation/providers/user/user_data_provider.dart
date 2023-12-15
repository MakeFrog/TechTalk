import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/providers/user/auth/user_auth_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  FutureOr<UserDataEntity?> build() async {
    try {
      final userAuth = ref.watch(userAuthProvider);

      if (userAuth == null) throw const UnAuthorizedException();

      final userData = await getUserDataUseCase();

      return userData;
    } on UnAuthorizedException catch (e) {
      ToastService.show(
        NormalToast(message: '$e'),
      );

      rethrow;
    }
  }

  Future<void> createUserData() async {
    try {
      await createUserDataUseCase();

      ref.invalidateSelf();

      await future;
    } on AlreadyExistUserDataException catch (e) {
      ToastService.show(
        NormalToast(message: '$e'),
      );

      rethrow;
    }
  }

  Future<void> updateUserData(UserDataEntity data) async {
    try {
      await updateUserDataUseCase(data);

      state = AsyncData(data);
    } on AlreadyExistNicknameException catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserData() async {
    await deleteUserDataUseCase();
    ref.invalidateSelf();
  }
}
