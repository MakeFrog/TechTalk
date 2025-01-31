import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/repositories/entities/job_group_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/user/data_source/remote/models/watched_youtube_content_model.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_entity.dart';

final class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(
    this._userRemoteDataSource,
    this._userLocalDataSource,
    this._techSetRepository,
  );

  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;
  final TechSetRepository _techSetRepository;

  @override
  Future<Result<void>> createUser(UserEntity data) async {
    try {
      final createdUser = await _userRemoteDataSource.createUser(data);

      return Result.success(createdUser);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserEntity>> getUser([String? uid]) async {
    try {
      final remoteRes = await _userRemoteDataSource.getUser();
      final localRes = _userLocalDataSource.loadUserLocalInfo();
      final List<SkillEntity> skills = remoteRes.techSkills != null
          ? remoteRes.techSkills!.map(_techSetRepository.getSkillById).toList()
          : [];

      skills.removeWhere((e) => e.id == SkillEntity.undefinedKey);

      final List<JobGroupEntity> jobGroups = remoteRes.jobGroupIds != null
          ? remoteRes.jobGroupIds!
              .map(_techSetRepository.getJobGroupById)
              .toList()
          : [];

      final result = UserEntity.fromModel(
        remoteRes,
        skills: skills,
        box: localRes,
        jobGroups: jobGroups,
      );

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateUser(UserEntity data) async {
    try {
      await _userRemoteDataSource.updateUser(data);

      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> deleteUser(UserEntity user) async {
    try {
      return Result.success(
        await _userRemoteDataSource.deleteUser(
          UserModel.fromEntity(user),
        ),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<String>> uploadImgFileAndGetUrl(File imageFile) async {
    try {
      final response =
          await _userRemoteDataSource.uploadImgFileAndGetUrl(imageFile);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<bool>> isNicknameDuplicated(String nickname) async {
    try {
      final response = await _userRemoteDataSource.isExistNickname(nickname);

      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> storeUserLocalInfo(UserEntity user) async {
    try {
      final response = await _userLocalDataSource.storeUserLocalInfo(user);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<int>> increaseCompletedInterviewCount() async {
    try {
      final response =
          await _userRemoteDataSource.increaseCompletedInterviewCount();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateLastLoginDate() async {
    try {
      final response = await _userRemoteDataSource.updateLastLoginDate();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> disableReviewAvailableState() async {
    try {
      final response = await _userLocalDataSource.disableReviewAvailableState();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<bool> hasEnteredFirstInterview() {
    try {
      final response =
          _userLocalDataSource.loadUserLocalInfo().hasEnteredFirstInterview;
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<bool> hasSeenNewYoutubeFeature() {
    try {
      final response =
          _userLocalDataSource.loadUserLocalInfo().hasSeenNewYoutubeFeature;
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> changeFirstEnteredFieldToTrue() async {
    try {
      await _userLocalDataSource.changeFirstEnteredFieldToTrue();
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<bool>> isContentBookMarked(String contentId) async {
    try {
      final result =
          await _userRemoteDataSource.checkIfContentIsBooMarked(contentId);
      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception('UserRepository > $e'));
    }
  }

  @override
  Future<Result<void>> updateBookMarkState(
      {required String contentId, required bool targetState}) async {
    try {
      await _userRemoteDataSource.updateBookMarkState(
          contentId: contentId, targetState: targetState);
      return Result.success(null);
    } catch (e) {
      return Result.failure(Exception('UserRepository > $e'));
    }
  }

  @override
  Future<Result<void>> updateYoutubeWatchHistory(String contentId) async {
    try {
      await _userRemoteDataSource.updateYoutubeWatchHistory(contentId);
      return Result.success(null);
    } catch (e) {
      return Result.failure(Exception('UserRepository > $e'));
    }
  }

  @override
  Future<
      Result<
          FirebasePaginatedResult<WatchedYoutubeContent,
              WatchedYoutubeContent>>> getPagedWatchedYoutubeHistory(
      {DocumentSnapshot<WatchedYoutubeContent>? lastDocument,
      required int limit}) async {
    try {
      final response =
          await _userRemoteDataSource.getPagedWatchedYoutubeHistory(
              limit: limit, lastDocument: lastDocument);

      final entities = response.items.map((res) {
        final model = res.info;
        final skills =
            model.relatedSkillIds.map(_techSetRepository.getSkillById).toList();
        final jobGroups = model.relatedJobGroupIds
            .map(_techSetRepository.getJobGroupById)
            .toList();
        return model.toEntity(skills, jobGroups);
      }).toList();

      final paginatedResult =
          FirebasePaginatedResult<YoutubeMainEntity, String>(
        items: entities,
        lastDocumentId: response.lastDocumentId,
        hasMore: response.hasMore,
      );

      return Result.success(response);
    } catch (e) {
      throw Result.failure(Exception('UserRepository> $e'));
    }
  }

  @override
  Future<Result<void>> disableNewFeatureShowState() async {
    try {
      final prev = _userLocalDataSource.loadUserLocalInfo();
      final target = prev.copyWith(hasSeenNewYoutubeFeature: true);
      await _userLocalDataSource.storeNewLocalState(target);
      return Result.success(null);
    } catch (e) {
      logger.e(e);
      return Result.failure(Exception(e));
    }
  }
}
