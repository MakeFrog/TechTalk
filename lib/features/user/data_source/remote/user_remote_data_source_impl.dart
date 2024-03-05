import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/user.dart';

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
}
