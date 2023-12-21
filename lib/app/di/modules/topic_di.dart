import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/topic/data/local/topic_local_data_source_impl.dart';
import 'package:techtalk/features/topic/data/remote/topic_remote_data_source_impl.dart';
import 'package:techtalk/features/topic/repositories/topic_repository_impl.dart';
import 'package:techtalk/features/topic/topic.dart';

final class TopicDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator
      ..registerLazySingleton<TopicLocalDataSource>(
        TopicLocalDataSourceImpl.new,
      )
      ..registerLazySingleton<TopicRemoteDataSource>(
        TopicRemoteDataSourceImpl.new,
      );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<TopicRepository>(
      () => TopicRepositoryImpl(
        remoteDataSource: topicRemoteDataSource,
        localDataSource: topicLocalDataSource,
      ),
    );
  }

  @override
  void useCases() {
    locator
      ..registerFactory(
        () => GetTopicsUseCase(
          topicRepository,
        ),
      )
      ..registerFactory(
        () => GetTopicUseCase(
          topicRepository,
        ),
      )
      ..registerFactory(
        SearchTopicsUseCase.new,
      )
      ..registerFactory(
        () => GetTopicQuestionsUseCase(
          topicRepository,
        ),
      );
  }
}
