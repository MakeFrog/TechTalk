import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/core/modules/local/app_local.dart';
import 'package:techtalk/features/interview/data_source/local/interview_local_data_source.dart';
import 'package:techtalk/features/interview/data_source/local/interview_local_data_source_impl.dart';
import 'package:techtalk/features/interview/index.dart';
import 'package:techtalk/features/interview/repository/interview_repository.dart';
import 'package:techtalk/features/interview/repository/interview_repository_impl.dart';

final class InterviewDepenencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<InterviewLocalDataSource>(
      () => InterviewLocalDataSourceImpl(
        AppLocal.proficiencyQuestionHistoryBox,
      ),
    );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<InterviewRepository>(
      () => InterviewRepositoryImpl(
        interviewLocalDataSource,
      ),
    );
  }

  @override
  void useCases() {}
}
