import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/providers/user/auth/user_auth_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'user_info_provider.g.dart';

@Riverpod(keepAlive: true)
class UserInfo extends _$UserInfo {
  @override
  FutureOr<UserEntity?> build() async {
    final userAuth = ref.watch(userAuthProvider);

    if (userAuth == null) throw const UnAuthorizedException();

    final userData = await getUserUseCase();

    return userData.fold(
      onSuccess: (value) => value,
      onFailure: (e) => null,
    );
  }

  Future<void> createData(UserEntity data) async {
    final createUserData = await createUserUseCase(data);
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

  void edit(UserEntity user) {
    state = AsyncData(user);
  }

  Future<void> updateData(UserEntity data) async {
    final updateUserData = await updateUserUseCase(data);
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

  Future<void> updateTopicRecordsOnCondition(List<TopicEntity> topics) async {
    final currentRecords = state.requireValue!.recordedTopics;

    final updatedTopicRecords =
        state.requireValue!.recordedTopics.toCombinedSetList(topics).toList();

    if (!updatedTopicRecords.isElementEquals(currentRecords)) {
      final updatedUserInfo =
          state.requireValue!.copyWith(recordedTopicIds: updatedTopicRecords);

      final response = await updateUserUseCase(updatedUserInfo);
      response.fold(
        onSuccess: (userInfo) {
          state = AsyncData(updatedUserInfo);
          log('유저 면접 기록 업데이트 성공');
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

  ///
  /// 실전 면접 기록 존재 여부 값을 로컬에 저장
  ///
  Future<void> storeUserPracticalRecordExistInfo() async {
    final user = state.requireValue!;

    if (user.hasPracticalInterviewRecord == true) return;

    final updateUser = user.copyWith(hasPracticalInterviewRecord: true);
    await update((_) => updateUser);
    final response = await storeUserLocalInfo.call(updateUser);

    response.fold(
      onSuccess: (_) {
        log('유저 로컬 정보 업데이트 성공');
      },
      onFailure: (e) {
        log('유저 로컬 정보 업데이트 실패');
      },
    );
  }

  Future<void> deleteData() async {
    final deleteUserData = await deleteUserUseCase();
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
