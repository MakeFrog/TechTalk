import 'package:get_it/get_it.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/interview/data/local/interview_local_data_source_impl.dart';
import 'package:techtalk/features/interview/data/remote/interview_remote_data_source_impl.dart';
import 'package:techtalk/features/interview/interview.dart';
import 'package:techtalk/features/interview/repositories/interview_repository_impl.dart';
import 'package:techtalk/features/interview/usecases/get_interview_topics_use_case.dart';
import 'package:techtalk/features/interview/usecases/get_review_note_question_list_use_case.dart';
import 'package:techtalk/features/user/user.dart';

final class InterviewDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    GetIt.I
      ..registerLazySingleton<InterviewLocalDataSource>(
        InterviewLocalDataSourceImpl.new,
      )
      ..registerLazySingleton<InterviewRemoteDataSource>(
        InterviewRemoteDataSourceImpl.new,
      );
  }

  @override
  void repositories() {
    GetIt.I.registerLazySingleton<InterviewRepository>(
      () => InterviewRepositoryImpl(
        interviewLocalDataSource: interviewLocalDataSource,
        interviewRemoteDataSource: interviewRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    GetIt.I
      ..registerFactory<GetInterviewTopicListUseCase>(
        () => GetInterviewTopicListUseCase(
          interviewRepository: interviewRepository,
          userRepository: userRepository,
        ),
      )
      ..registerFactory<GetReviewNoteQuestionListUseCase>(
        () => GetReviewNoteQuestionListUseCase(
          interviewRepository,
        ),
      );
  }
}
