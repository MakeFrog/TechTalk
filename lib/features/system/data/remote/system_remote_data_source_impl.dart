import 'dart:io';

import 'package:techtalk/features/system/data/model/system_ref.dart';
import 'package:techtalk/features/system/data/model/version_model.dart';
import 'package:techtalk/features/system/data/remote/system_remote_data_source.dart';

final class SystemRemoteDataSourceImpl implements SystemRemoteDataSource {
  @override
  Future<VersionModel> getVersionInfo() async {
    final targetDocPath = Platform.isIOS ? 'ios' : 'android';

    final versionRef = await FirestoreVersionRef.doc(targetDocPath).get();

    return versionRef.data()!;
  }
}
