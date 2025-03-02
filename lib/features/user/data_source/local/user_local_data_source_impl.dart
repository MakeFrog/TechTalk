import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/user/data_source/local/boxes/portfolio_box.dart';
import 'package:techtalk/features/user/data_source/local/boxes/resume_box.dart';
import 'package:techtalk/features/user/repositories/entities/portfolio_entity.dart';
import 'package:techtalk/features/user/repositories/entities/resume_entity.dart';
import 'package:techtalk/features/user/user.dart';

final class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this.box);

  final Box<UserBox> box;

  UserBox? get localUser => box.get(AppLocal.userBoxName);

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
  Future<void> changeResumeData(ResumeEntity? newResume) async {
    try {
      final userLocalInfo = localUser ?? UserBox.defaultValue();

      if (newResume == null) {
        final updatedUserBox = userLocalInfo.deleteResume();
        await box.put(AppLocal.userBoxName, updatedUserBox);
      } else {
        final updatedUserBox = userLocalInfo.copyWith(
          resume: ResumeBox(
            resumePath: newResume.path,
            resumeTitle: newResume.title,
            resumeUploadAt: newResume.uploadAt,
          ),
        );
        await box.put(AppLocal.userBoxName, updatedUserBox);
      }
    } catch (e, s) {
      debugPrint('[로컬] box.put 예외 발생: $e');
      debugPrint('$s');
      rethrow;
    }
  }

  @override
  Future<void> changePortfolioData(PortfolioEntity? newPortfolio) async {
    try {
      final userLocalInfo = localUser ?? UserBox.defaultValue();

      if (newPortfolio == null) {
        final updatedUserBox = userLocalInfo.deletePortfolio();
        await box.put(AppLocal.userBoxName, updatedUserBox);
      } else {
        final updatedUserBox = userLocalInfo.copyWith(
          portfolio: PortfolioBox(
            portfolioPath: newPortfolio.path,
            portfolioTitle: newPortfolio.title,
            portfolioUploadAt: newPortfolio.uploadAt,
          ),
        );
        await box.put(AppLocal.userBoxName, updatedUserBox);
      }
    } catch (e, s) {
      debugPrint('[로컬] box.put 예외 발생: $e');
      debugPrint('$s');
      rethrow;
    }
  }
}
