import 'package:hive/hive.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
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
          UserBox.defaultValue().copyWith(hasEnteredFirstInterview: true),
    );
  }

  @override
  Future<void> changeResumeData(ResumeEntity resume) async {
    final userLocalInfo = localUser ?? UserBox.defaultValue();

    final updated = userLocalInfo.copyWith(
      resumePdfPath: resume.path,
      resumePdfTitle: resume.title,
      resumePdfDate: resume.uploadAt,
    );
    await box.put(AppLocal.userBoxName, updated);
  }

  @override
  Future<void> changePortfolioData(PortfolioEntity portfolio) async {
    final userLocalInfo = localUser ?? UserBox.defaultValue();

    final updated = userLocalInfo.copyWith(
      portfolioPdfPath: portfolio.path,
      portfolioPdfTitle: portfolio.title,
      portfolioPdfDate: portfolio.uploadAt,
    );
    await box.put(AppLocal.userBoxName, updated);
  }
}
