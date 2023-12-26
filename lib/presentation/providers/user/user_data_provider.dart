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
    final userAuth = ref.watch(userAuthProvider);

    if (userAuth == null) throw const UnAuthorizedException();

    final userData = await getUserDataUseCase();

    return userData.fold(
      onSuccess: (value) {
        return value;
      },
      onFailure: (e) {
        ToastService.show(
          NormalToast(message: '$e'),
        );

        throw e;
      },
    );
  }

  Future<void> createData() async {
    final createUserData = await createUserDataUseCase();
    await createUserData.fold(
      onSuccess: (value) async {
        ref.invalidateSelf();

        await future;
      },
      onFailure: (e) {
        ToastService.show(
          NormalToast(message: '$e'),
        );

        throw e;
      },
    );
  }

  Future<void> updateData(UserDataEntity data) async {
    final updateUserData = await updateUserDataUseCase(data);
    updateUserData.fold(
      onSuccess: (value) {
        state = AsyncData(data);
      },
      onFailure: (e) {
        ToastService.show(
          NormalToast(message: '$e'),
        );

        throw e;
      },
    );
  }

  Future<void> deleteData() async {
    final deleteUserData = await deleteUserDataUseCase();
    deleteUserData.fold(
      onSuccess: (value) {
        ref.invalidateSelf();
      },
      onFailure: (e) {
        ToastService.show(
          NormalToast(message: '$e'),
        );

        throw e;
      },
    );
  }
}
