import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/repositories/entities/job_group_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skillt_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/user/data_source/remote/models/bookmarked_youtube_content_model.dart';
import 'package:techtalk/features/user/data_source/remote/models/uploaded_youtube_content_model.dart';
import 'package:techtalk/features/user/data_source/remote/models/watched_youtube_content_model.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_entity.dart';
import 'package:techtalk/features/youtube/index.dart';

final class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(
    this._userRemoteDataSource,
    this._userLocalDataSource,
    this._youtubeRemoteDataSource,
    this._techSetRepository,
  );

  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;
  final YoutubeRemoteDataSource _youtubeRemoteDataSource;
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
              FirebasePaginatedResult<YoutubeMainEntity, WatchedYoutubeModel>>>
      getPagedWatchedYoutubeHistory({
    DocumentSnapshot<WatchedYoutubeModel>? lastDocument,
    required int limit,
  }) async {
    try {
      final response =
          await _userRemoteDataSource.getPagedWatchedYoutubeHistory(
        limit: limit,
        lastDocument: lastDocument,
      );
      final rawEntities = await Future.wait(
        response.items.map((res) async {
          try {
            // id를 사용하여 유튜브 컬렉션에서 상세 정보를 가져옴
            final model = await _youtubeRemoteDataSource
                .getSingleYoutubeMainContent(contentId: res.id);

            final skills = model.relatedSkillIds
                .map(_techSetRepository.getSkillById)
                .toList();

            final jobGroups = model.relatedJobGroupIds
                .map(_techSetRepository.getJobGroupById)
                .toList();

            return model.toEntity(skills, jobGroups);
          } catch (e) {
            // 여기서 예외가 발생하면 null을 반환하여 해당 아이템만 건너뛰도록 함
            return null;
          }
        }).toList(),
      );

      // null이 아닌 실제 값들만 필터링
      final entities = rawEntities.whereType<YoutubeMainEntity>().toList();

      final paginatedResult =
          FirebasePaginatedResult<YoutubeMainEntity, WatchedYoutubeModel>(
        items: entities,
        lastDocument: response.lastDocument,
        lastDocumentId: response.lastDocumentId,
        hasMore: response.hasMore,
      );

      return Result.success(paginatedResult);
    } catch (e) {
      throw Result.failure(Exception('UserRepository> $e'));
    }
  }

  @override
  Future<
      Result<
          FirebasePaginatedResult<YoutubeMainEntity,
              BookmarkedYoutubeModel>>> getPagedBookmarkedYoutube({
    DocumentSnapshot<BookmarkedYoutubeModel>? lastDocument,
    required int limit,
  }) async {
    try {
      // 1. 북마크된 유튜브 목록 문서 가져오기
      final response = await _userRemoteDataSource.getPagedBookmarkedYoutube(
        limit: limit,
        lastDocument: lastDocument,
      );

      // 2. 가져온 북마크 목록(response.items)에 대해 상세 정보를 병렬로 조회
      final rawEntities = await Future.wait(
        response.items.map((res) async {
          try {
            // id를 사용하여 유튜브 컬렉션에서 상세 정보를 가져옴
            final model = await _youtubeRemoteDataSource
                .getSingleYoutubeMainContent(contentId: res.id);

            final skills = model.relatedSkillIds
                .map(_techSetRepository.getSkillById)
                .toList();

            final jobGroups = model.relatedJobGroupIds
                .map(_techSetRepository.getJobGroupById)
                .toList();

            return model.toEntity(skills, jobGroups);
          } catch (e) {
            // 여기서 예외가 발생하면 null을 반환하여 해당 아이템만 건너뛰도록 함
            return null;
          }
        }).toList(),
      );

      // 3. null이 아닌 실제 값들만 필터링
      final entities = rawEntities.whereType<YoutubeMainEntity>().toList();

      // 4. 페이징 결과 구성
      final paginatedResult =
          FirebasePaginatedResult<YoutubeMainEntity, BookmarkedYoutubeModel>(
        items: entities,
        lastDocument: response.lastDocument,
        lastDocumentId: response.lastDocumentId,
        hasMore: response.hasMore,
      );

      return Result.success(paginatedResult);
    } catch (e) {
      // getPagedBookmarkedYoutube 자체가 실패했을 때는 전체 예외 처리
      // (예: 네트워크 등)
      return Result.failure(Exception('UserRepository> $e'));
    }
  }

  @override
  Future<
          Result<
              FirebasePaginatedResult<YoutubeMainEntity, UploadedYoutubeModel>>>
      getPagedUploadedYoutube({
    DocumentSnapshot<UploadedYoutubeModel>? lastDocument,
    required int limit,
  }) async {
    try {
      final response = await _userRemoteDataSource.getPagedUploadedYoutube(
        limit: limit,
        lastDocument: lastDocument,
      );

      final rawEntities = await Future.wait(
        response.items.map((res) async {
          try {
            // id를 사용하여 유튜브 컬렉션에서 상세 정보를 가져옴
            final model = await _youtubeRemoteDataSource
                .getSingleYoutubeMainContent(contentId: res.id);

            final skills = model.relatedSkillIds
                .map(_techSetRepository.getSkillById)
                .toList();

            final jobGroups = model.relatedJobGroupIds
                .map(_techSetRepository.getJobGroupById)
                .toList();

            return model.toEntity(skills, jobGroups);
          } catch (e) {
            // 여기서 예외가 발생하면 null을 반환하여 해당 아이템만 건너뛰도록 함
            return null;
          }
        }).toList(),
      );

      // null이 아닌 실제 값들만 필터링
      final entities = rawEntities.whereType<YoutubeMainEntity>().toList();

      final paginatedResult =
          FirebasePaginatedResult<YoutubeMainEntity, UploadedYoutubeModel>(
        items: entities,
        lastDocument: response.lastDocument,
        lastDocumentId: response.lastDocumentId,
        hasMore: response.hasMore,
      );

      return Result.success(paginatedResult);
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
