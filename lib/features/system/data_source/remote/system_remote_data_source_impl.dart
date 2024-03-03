import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/system/system.dart';

final class SystemRemoteDataSourceImpl implements SystemRemoteDataSource {
  @override
  Future<VersionModel> getVersionInfo() async {
    try {
      final targetDocPath = Platform.isIOS ? 'ios' : 'android';

      final versionRef = await FirestoreVersionRef.doc(targetDocPath)
          .get(const GetOptions(source: Source.server));

      return versionRef.data()!;
    } catch (e) {
      log('버전 정보 호출 실패 : $e');
      rethrow;
    }
  }
}
