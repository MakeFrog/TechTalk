import 'package:hive/hive.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/user.dart';

final class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this.box);

  final Box<UserBox> box;

  UserBox? get localUser => box.values.firstOrNull;

  @override
  Future<void> storeUserLocalInfo(UserEntity user) async {
    final userLocalInfo = localUser?.copyWith(
          hasPracticalInterviewRecord: user.hasPracticalInterviewRecord,
        ) ??
        UserBox.defaultValue();
    return box.put(AppLocal.userBoxName, userLocalInfo);
  }

  @override
  UserBox loadUserLocalInfo() {
    return localUser ?? UserBox.defaultValue();
  }

  @override
  Future<void> disableReviewAvailableState() {
    final userLocalInfo = localUser?.copyWith(
          isReviewRequestAvailable: false,
        ) ??
        UserBox.defaultValue();
    return box.put(AppLocal.userBoxName, userLocalInfo);
  }

  @override
  Future<void> changeFirstEnteredFieldToTrue() async {
    final userLocalInfo = localUser?.copyWith(hasEnteredFirstInterview: true);

    await box.put(
        AppLocal.userBoxName,
        userLocalInfo ??
            UserBox.defaultValue().copyWith(hasEnteredFirstInterview: true));
  }
}
