import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:techtalk/core/index.dart';
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
    debugPrint('===== UserLocalDataSourceImpl.changeResumeData =====');
    debugPrint('UserLocalDataSourceImpl - newResume : ${newResume?.path}');
    debugPrint('UserLocalDataSourceImpl - newResume : ${newResume?.title}');

    try {
      final userLocalInfo = localUser ?? UserBox.defaultValue();

      // TODO: 해당 메서드 고치기
      // final updatedUserBox = userLocalInfo.copyWith(
      //   resume: newResume?.path != null
      //       ? userLocalInfo.resume?.copyWith(
      //           resumePath: newResume?.path,
      //           resumeTitle: newResume?.title,
      //           resumeUploadAt: newResume?.uploadAt,
      //         )
      //       : null,
      // );

      final updatedUserBox = userLocalInfo.copyWith(
        resume: ResumeBox(
          resumePath: newResume?.path,
          resumeTitle: newResume?.title,
          resumeUploadAt: newResume?.uploadAt,
        ),
      );

      debugPrint('=== updatedUserBox:  ${updatedUserBox.resume?.resumeTitle}');

      await box.put(AppLocal.userBoxName, updatedUserBox);

      debugPrint('resumePath  이력서 경로 ${localUser?.resume?.resumePath}');
    } catch (e, s) {
      debugPrint('[로컬] box.put 예외 발생: $e');
      debugPrint('$s');
      rethrow;
    }
  }

  @override
  Future<void> changePortfolioData(PortfolioEntity? newPortfolio) async {
    final userLocalInfo = localUser ?? UserBox.defaultValue();

    final updatedUserBox = userLocalInfo.copyWith(
      portfolio: userLocalInfo.portfolio?.copyWith(
        portfolioPath: newPortfolio?.path,
        portfolioTitle: newPortfolio?.title,
        portfolioUploadAt: newPortfolio?.uploadAt,
      ),
    );
    await box.put(AppLocal.userBoxName, updatedUserBox);
  }
}
