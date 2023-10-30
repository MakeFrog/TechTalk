import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/interview/data/local/interview_local_data_source_impl.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/features/interview/repositories/interview_repository_impl.dart';

final class InterviewDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<InterviewLocalDataSource>(
      InterviewLocalDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    final interviewRemoteDataSource = locator<InterviewLocalDataSource>();

    locator.registerLazySingleton<InterviewRepository>(
      () => InterviewRepositoryImpl(
        interviewRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    final interviewRepository = locator<InterviewRepository>();

    locator.registerFactory<GetInterviewTopicListUseCase>(
      () => GetInterviewTopicListUseCase(
        interviewRepository,
      ),
    );
  }
}
