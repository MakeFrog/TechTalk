import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/system/data/model/version_model.dart';
import 'package:techtalk/features/system/data/remote/system_remote_data_source.dart';

final class SystemRemoteDataSourceImpl implements SystemRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<VersionModel> getVersionInfo() async {
    final targetDocPath = Platform.isIOS ? 'ios' : 'android';

    final versionRef = await _firestore
        .collection('Version')
        .doc(targetDocPath)
        .withConverter(
          fromFirestore: VersionModel.fromFirestore,
          toFirestore: (model, _) => model.toJson(),
        )
        .get();

    return versionRef.data()!;
  }
}
