import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/providers/user/user_auth_provider.dart';

part 'user_info_provider.g.dart';

@Riverpod(keepAlive: true)
class UserInfo extends _$UserInfo {
  @override
  FutureOr<UserEntity?> build() async {
    final userAuth = ref.watch(userAuthProvider);

    if (userAuth == null) {
      throw Exception('유저 인증 정보가 존재하지 않습니다(로그아웃 이후 다시 로그인 시도할 경우 정상적인 시도입니다)');
    }

    final userData = await getUserUseCase();

    return userData.fold(
      onSuccess: (value) {
        return value;
      },
      onFailure: (e) {
        return null;
      },
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
        SnackBarService.showSnackBar('$e');

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
        SnackBarService.showSnackBar('$e');

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
          state.requireValue!.copyWith(recordedTopics: updatedTopicRecords);

      final response = await updateUserUseCase(updatedUserInfo);
      response.fold(
        onSuccess: (userInfo) {
          state = AsyncData(updatedUserInfo);
          log('유저 면접 기록 업데이트 성공');
        },
        onFailure: (e) {
          SnackBarService.showSnackBar('$e');

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

    final updatedUser = user.copyWith(hasPracticalInterviewRecord: true);
    await update((_) => updatedUser);
    final response = await storeUserLocalInfo.call(updatedUser);

    response.fold(
      onSuccess: (_) {
        log('유저 로컬 정보 업데이트 성공');
      },
      onFailure: (e) {
        log('유저 로컬 정보 업데이트 실패');
      },
    );
  }

  ///
  /// 회원탈퇴
  ///
  Future<void> resign() async {
    final response = await resignUserInfoUseCase(state.requireValue!);
    response.fold(
      onSuccess: (value) {
        ref.invalidateSelf();
      },
      onFailure: (e) {
        SnackBarService.showSnackBar('$e');

        throw e;
      },
    );
  }
}
