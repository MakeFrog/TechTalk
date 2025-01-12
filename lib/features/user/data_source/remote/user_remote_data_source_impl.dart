import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:techtalk/core/firebase_pagination_result.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/data_source/remote/models/watched_youtube_content_model.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/channel_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/models/youtube_main_model.dart';
import 'package:techtalk/features/youtube/data_source/remote/youtube_ref.dart';

final class UserRemoteDataSourceImpl implements UserRemoteDataSource {
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
            'youtube_ref': FirestoreYoutubeRef.doc(contentId),
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
        'youtube_ref': FirestoreYoutubeRef.doc(contentId),
        'watched_at': DateTime.timestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FirebasePaginatedResult<WatchedYoutubeContent, WatchedYoutubeContent>>
      getPagedWatchedYoutubeHistory({
    DocumentSnapshot<WatchedYoutubeContent>? lastDocument, // Object?로 유지
    required int limit,
  }) async {
    try {
      Query<WatchedYoutubeContent> query =
          FirestoreUsersRef.watchedYoutubeHistoryCollection()
              .orderBy('watched_at', descending: true)
              .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      QuerySnapshot<WatchedYoutubeContent> snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        return FirebasePaginatedResult<WatchedYoutubeContent,
            WatchedYoutubeContent>(
          items: [],
          hasMore: false,
          hasReversedQueryCallProceeded: true,
        );
      }

      final items = await Future.wait(snapshot.docs.map((doc) async {
        final youtubeRef = doc.get('youtube_ref') as DocumentReference;

        // YoutubeMainModel 데이터 가져오기
        final youtube =
            await youtubeRef.get() as DocumentSnapshot<Map<String, dynamic>>;
        final mainModel = YoutubeMainModel.fromFirestore(youtube, null);

        // ChannelModel 데이터 가져오기
        final channelSnapshot = await mainModel.channelRef?.get()
            as DocumentSnapshot<Map<String, dynamic>>;
        final channelModel = ChannelModel.fromFirestore(channelSnapshot, null);

        return WatchedYoutubeContent(
          info: mainModel.copyWith(channel: channelModel),
          watchedAt: (doc.get('watched_at') as Timestamp).toDate(),
        );
      }).toList());

      final hasMore = snapshot.docs.length == limit;

      final newLastDocument =
          snapshot.docs.isNotEmpty ? snapshot.docs.last : lastDocument;

      return FirebasePaginatedResult<WatchedYoutubeContent,
          WatchedYoutubeContent>(
        items: items,
        lastDocument: newLastDocument,
        hasMore: hasMore,
      );
    } catch (e) {
      log('페이징 호출 실패: $e');
      rethrow;
    }
  }
}
