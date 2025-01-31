import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/features/user/data_source/remote/models/bookmarked_youtube_content_model.dart';
import 'package:techtalk/features/user/data_source/remote/models/uploaded_youtube_content_model.dart';
import 'package:techtalk/features/user/data_source/remote/models/watched_youtube_content_model.dart';
import 'package:techtalk/features/user/user.dart';

abstract interface class UserRemoteDataSource {
  ///
  /// 유저 정보 생성
  ///
  Future<void> createUser(UserEntity data);

  ///
  /// 유저 정보 업데이트
  ///
  Future<void> updateUser(UserEntity data);

  ///
  /// 유저 정보 호출
  ///
  Future<UserModel> getUser([String? uid]);

  ///
  /// 유저 정보 삭제
  ///
  Future<void> deleteUser(UserModel user);

  ///
  /// 닉네임 중복 검사
  ///
  Future<bool> isExistNickname(String nickname);

  ///
  /// storage에 이미지 파일을 업로드하고 url를 리턴
  ///
  Future<String> uploadImgFileAndGetUrl(File imageFile);

  ///
  /// 마지막 접속 일자 갱신
  ///
  Future<void> updateLastLoginDate();

  ///
  /// 완료된 면접 개수 필드 증가 및 값 리턴
  ///
  Future<int> increaseCompletedInterviewCount();

  ///
  /// 북마크 되어 잇는 콘텐츠인지 여부
  ///
  Future<bool> checkIfContentIsBooMarked(String contentId);

  ///
  /// 북마크 상태 업데이트
  ///
  Future<void> updateBookMarkState({
    required String contentId,
    required bool targetState,
  });

  ///
  /// 유튜브 영상 기록 추가
  ///
  Future<void> updateYoutubeWatchHistory(String contentId);

  ///
  /// 유튜브 영상 기록 호출
  ///
  Future<FirebasePaginatedResult<WatchedYoutubeModel, WatchedYoutubeModel>>
      getPagedWatchedYoutubeHistory({
    DocumentSnapshot<WatchedYoutubeModel>? lastDocument,
    required int limit,
  });

  ///
  /// 유튜브 북마크 기록 호출
  ///
  Future<
      FirebasePaginatedResult<BookmarkedYoutubeModel,
          BookmarkedYoutubeModel>> getPagedBookmarkedYoutube({
    DocumentSnapshot<BookmarkedYoutubeModel>? lastDocument,
    required int limit,
  });

  ///
  /// 유튜브 업로드 기록 호출
  ///
  Future<FirebasePaginatedResult<UploadedYoutubeModel, UploadedYoutubeModel>>
      getPagedUploadedYoutube({
    DocumentSnapshot<UploadedYoutubeModel>? lastDocument,
    required int limit,
  });
}
