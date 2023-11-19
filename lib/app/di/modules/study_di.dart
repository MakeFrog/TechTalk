import 'package:get_it/get_it.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/study/data/local/study_local_data_source_impl.dart';
import 'package:techtalk/features/study/data/remote/study_remote_data_source_impl.dart';
import 'package:techtalk/features/study/repositories/study_repository_impl.dart';
import 'package:techtalk/features/study/study.dart';

final class StudyDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    GetIt.I
      ..registerLazySingleton<StudyRemoteDataSource>(
        StudyRemoteDataSourceImpl.new,
      )
      ..registerLazySingleton<StudyLocalDataSource>(
        StudyLocalDataSourceImpl.new,
      );
  }

  @override
  void repositories() {
    GetIt.I.registerLazySingleton<StudyRepository>(
      () => StudyRepositoryImpl(
        studyRemoteDataSource: studyRemoteDataSource,
        studyLocalDataSource: studyLocalDataSource,
      ),
    );
  }

  @override
  void useCases() {
    GetIt.I.registerFactory<GetStudyQuestionListUseCase>(
      () => GetStudyQuestionListUseCase(
        studyRepository,
      ),
    );
  }
}
