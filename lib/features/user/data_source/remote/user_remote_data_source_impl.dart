import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/data_source/remote/models/bookmarked_youtube_content_model.dart';
import 'package:techtalk/features/user/data_source/remote/models/uploaded_youtube_content_model.dart';
import 'package:techtalk/features/user/data_source/remote/models/watched_youtube_content_model.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
import 'package:techtalk/features/user/user.dart';

final class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<bool> isExistNickname(
    String nickname,
  ) async {
    final docRef = await FirestoreUsersRef.collection()
        .where('nickname', isEqualTo: nickname)
        .get();

    return docRef.docs.isNotEmpty;
  }

  @override
  Future<void> createUser(UserEntity data) async {
    if (await FirestoreUsersRef.isExist()) {
      throw const AlreadyExistUserDataException();
    }

    final userData = FirestoreUsersRef.doc();
    final user = UserModel.fromEntity(data);

    await userData.set(user);
  }

  @override
  Future<UserModel> getUser([String? uid]) async {
    if (!await FirestoreUsersRef.isExist()) {
      throw const NoUserDataException();
    }

    final snapshot = await FirestoreUsersRef.doc(uid).get();

    await FirestoreUsersRef.doc(uid).update({
      FirestoreUsersRef.lastLoginDateField: FieldValue.serverTimestamp(),
      FirestoreUsersRef.loginCountField: FieldValue.increment(1),
    });

    return snapshot.data()!;
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    if (!await FirestoreUsersRef.isExist()) {
      throw const NoUserDataException();
    }

    final userModel = UserModel.fromEntity(user);

    await FirestoreUsersRef.doc().update(
      userModel.updatedFieldToJson(),
    );
  }

  @override
  Future<void> deleteUser(UserModel user) async {
    final prevData = await FirestoreUsersRef.doc().get();

    await FirestoreUsersRef.doc('WITHDRAWN-${user.uid}').set(prevData.data()!);

    final subCollectionRef = FirestoreUsersRef.chatSubCollection();

    QuerySnapshot subCollectionSnapshot = await subCollectionRef.get();

    for (QueryDocumentSnapshot document in subCollectionSnapshot.docs) {
      await FirestoreUsersRef.chatSubCollection().doc(document.id).delete();
    }

    await FirestoreUsersRef.doc().delete();
  }

  @override
  Future<String> uploadImgFileAndGetUrl(File imageFile) async {
    final profileImgRef = FireStorageUserRef.profileImgRef;

    final snapshot = await profileImgRef.putFile(imageFile);

    if (snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      throw const ImgStoreFailedException();
    }
  }

  @override
  Future<int> increaseCompletedInterviewCount() async {
    if (!await FirestoreUsersRef.isExist()) {
      throw const NoUserDataException();
    }

    final snapshot = await FirestoreUsersRef.doc().get();

    await FirestoreUsersRef.doc().update({
      FirestoreUsersRef.completedInterviewCountField: FieldValue.increment(1),
    });

    return (snapshot.data()?.completedInterviewCount ?? 0) + 1;
  }

  @override
  Future<void> updateLastLoginDate() async {
    if (!await FirestoreUsersRef.isExist()) {
      throw const NoUserDataException();
    }

    await FirestoreUsersRef.doc().update({
      FirestoreUsersRef.lastLoginDateField: FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<bool> checkIfContentIsBooMarked(String contentId) async {
    try {
      final snapshot =
          await FirestoreUsersRef.bookMarkedYoutubeDoc(contentId).get();
      return snapshot.exists;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateBookMarkState(
      {required String contentId, required bool targetState}) async {
    try {
      if (targetState == true) {
        await FirestoreUsersRef.bookMarkedYoutubeDoc(contentId).set(
          {
            'id': contentId,
            'bookmarked_at': DateTime.timestamp(),
          },
        );
      } else {
        await FirestoreUsersRef.bookMarkedYoutubeDoc(contentId).delete();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateYoutubeWatchHistory(String contentId) async {
    try {
      await FirestoreUsersRef.watchedYoutubeHistoryDoc(contentId).set({
        'id': contentId,
        'watched_at': DateTime.timestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FirebasePaginatedResult<WatchedYoutubeModel, WatchedYoutubeModel>>
      getPagedWatchedYoutubeHistory({
    DocumentSnapshot<WatchedYoutubeModel>? lastDocument, // Object?로 유지
    required int limit,
  }) async {
    try {
      Query<WatchedYoutubeModel> query =
          FirestoreUsersRef.watchedYoutubeHistoryCollection()
              .orderBy('watched_at', descending: true)
              .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      QuerySnapshot<WatchedYoutubeModel> snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        return FirebasePaginatedResult<WatchedYoutubeModel,
            WatchedYoutubeModel>(
          items: [],
          hasMore: false,
          hasReversedQueryCallProceeded: true,
        );
      }

      final items = snapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      final hasMore = snapshot.docs.length == limit;

      final newLastDocument =
          snapshot.docs.isNotEmpty ? snapshot.docs.last : lastDocument;

      return FirebasePaginatedResult<WatchedYoutubeModel, WatchedYoutubeModel>(
        items: items,
        lastDocument: newLastDocument,
        hasMore: hasMore,
      );
    } catch (e) {
      log('페이징 호출 실패: $e');
      rethrow;
    }
  }

  @override
  Future<
      FirebasePaginatedResult<BookmarkedYoutubeModel,
          BookmarkedYoutubeModel>> getPagedBookmarkedYoutube({
    DocumentSnapshot<BookmarkedYoutubeModel>? lastDocument, // Object?로 유지
    required int limit,
  }) async {
    try {
      Query<BookmarkedYoutubeModel> query =
          FirestoreUsersRef.bookmarkedYoutubeHistoryCollection()
              .orderBy('bookmarked_at', descending: true)
              .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      QuerySnapshot<BookmarkedYoutubeModel> snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        return FirebasePaginatedResult<BookmarkedYoutubeModel,
            BookmarkedYoutubeModel>(
          items: [],
          hasMore: false,
          hasReversedQueryCallProceeded: true,
        );
      }
      final items = snapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      final hasMore = snapshot.docs.length == limit;

      final newLastDocument =
          snapshot.docs.isNotEmpty ? snapshot.docs.last : lastDocument;

      return FirebasePaginatedResult<BookmarkedYoutubeModel,
          BookmarkedYoutubeModel>(
        items: items,
        lastDocument: newLastDocument,
        hasMore: hasMore,
      );
    } catch (e) {
      log('페이징 호출 실패: $e');
      rethrow;
    }
  }

  @override
  Future<FirebasePaginatedResult<UploadedYoutubeModel, UploadedYoutubeModel>>
      getPagedUploadedYoutube({
    DocumentSnapshot<UploadedYoutubeModel>? lastDocument, // Object?로 유지
    required int limit,
  }) async {
    try {
      Query<UploadedYoutubeModel> query =
          FirestoreUsersRef.uploadedYoutubeCollection()
              .orderBy('upload_at', descending: true)
              .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      QuerySnapshot<UploadedYoutubeModel> snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        return FirebasePaginatedResult<UploadedYoutubeModel,
            UploadedYoutubeModel>(
          items: [],
          hasMore: false,
          hasReversedQueryCallProceeded: true,
        );
      }

      final items = snapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      final hasMore = snapshot.docs.length == limit;

      final newLastDocument =
          snapshot.docs.isNotEmpty ? snapshot.docs.last : lastDocument;

      return FirebasePaginatedResult<UploadedYoutubeModel,
          UploadedYoutubeModel>(
        items: items,
        lastDocument: newLastDocument,
        hasMore: hasMore,
      );
    } catch (e) {
      log('페이징 호출 실패: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateResume(ResumeEntity? resume) async {
    final folderRef = FireStorageUserRef.resumeFolderRef;

    // 이력서 삭제 로직
    if (resume == null || resume.path == null) {
      final mapData = {
        'resume': FieldValue.delete(),
      };
      await FirestoreUsersRef.doc().update(mapData);
      return;
    }

    // 파일명: resume_타임스탬프.pdf
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final safeTitle = resume.title?.replaceAll(' ', '_') ?? 'untitled';
    final fileName = 'resume_${safeTitle}_$timestamp.pdf';

    // 최종 경로: 'resume/{userUid}/resume_timestamp.pdf'
    // 중복으로 여러 데이터를 저장하기 위해 이름에 고유값 부여
    final finalRef = folderRef.child(fileName);

    // 이력서 파일
    final file = File(resume.path!);

    // Storage 업로드
    final snapshot = await finalRef.putFile(file);

    if (snapshot.state == TaskState.success) {
      // 업로드 성공 후, 파일의 다운로드 URL 얻기
      final String downloadUrl = await finalRef.getDownloadURL();

      final newResume = ResumeEntity(
        path: downloadUrl,
        title: resume.title,
        uploadAt: resume.uploadAt,
      );

      // Firestore에 저장할 Map 형태로 변환
      final mapData = {
        'resume': {
          'path': newResume.path,
          'title': newResume.title,
          'uploadAt': newResume.uploadAt,
        },
      };

      await FirestoreUsersRef.doc().update(mapData);
    } else {
      throw Exception('이력서 파일 저장 실패');
    }
  }

  @override
  Future<void> updatePortfolio(PortfolioEntity? portfolio) async {
    final folderRef = FireStorageUserRef.portfolioFolderRef;

    // 포트폴리오 삭제 로직
    if (portfolio == null || portfolio.path == null) {
      final mapData = {
        'portfolio': FieldValue.delete(),
      };
      await FirestoreUsersRef.doc().update(mapData);
      return;
    }

    // 파일명: portfolio_타임스탬프.pdf
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final safeTitle = portfolio.title?.replaceAll(' ', '_') ?? 'untitled';
    final fileName = 'portfolio_${safeTitle}_$timestamp.pdf';

    // 최종 경로: 'portfolio/{userUid}/portfolio_timestamp.pdf'
    // 중복으로 여러 데이터를 저장하기 위해 이름에 고유값 부여
    final finalRef = folderRef.child(fileName);

    // 포트폴리오 파일
    final file = File(portfolio.path!);

    // Storage 업로드
    final snapshot = await finalRef.putFile(file);

    if (snapshot.state == TaskState.success) {
      // 업로드 성공 후, 파일의 다운로드 URL 얻기
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      final newPortfolio = ResumeEntity(
        path: downloadUrl,
        title: portfolio.title,
        uploadAt: portfolio.uploadAt,
      );

      // Firestore에 저장할 Map 형태로 변환
      final mapData = {
        'portfolio': {
          'path': newPortfolio.path,
          'title': newPortfolio.title,
          'uploadAt': newPortfolio.uploadAt,
        },
      };

      await FirestoreUsersRef.doc().update(mapData);
    } else {
      throw Exception('포트폴리오 파일 저장 실패');
    }
  }
}
