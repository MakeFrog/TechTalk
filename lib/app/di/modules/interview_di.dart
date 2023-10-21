import 'package:get_it/get_it.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/interview/data/local/interview_local_data_source_impl.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/features/interview/repositories/interview_repository_impl.dart';

final class InterviewDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    GetIt.I.registerLazySingleton<InterviewLocalDataSource>(
      InterviewLocalDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    final interviewRemoteDataSource = GetIt.I<InterviewLocalDataSource>();

    GetIt.I.registerLazySingleton<InterviewRepository>(
      () => InterviewRepositoryImpl(
        interviewRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    final interviewRepository = GetIt.I<InterviewRepository>();

    GetIt.I.registerFactory<GetInterviewTopicListUseCase>(
      () => GetInterviewTopicListUseCase(
        interviewRepository,
      ),
    );
  }
}
