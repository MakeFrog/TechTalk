import 'package:hive/hive.dart';
import 'package:techtalk/app/local_storage/app_local.dart';
import 'package:techtalk/features/user/data/local/user_local_data_source.dart';
import 'package:techtalk/features/user/data/models/box/user_box.dart';
import 'package:techtalk/features/user/entities/user_entity.dart';

final class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this.box);

  final Box<UserBox> box;

  UserBox? get localUser => box.values.firstOrNull;

  @override
  bool hasPracticalInterviewRecord() {
    return localUser?.hasPracticalInterviewRecord ?? false;
  }

  @override
  Future<void> storeUserLocalInfo(UserEntity user) async {
    final userLocalInfo = localUser?.copyWith(
            hasPracticalInterviewRecord: user.hasPracticalInterviewRecord) ??
        UserBox.defaultValue();
    return box.put(AppLocal.userBoxName, userLocalInfo);
  }
}