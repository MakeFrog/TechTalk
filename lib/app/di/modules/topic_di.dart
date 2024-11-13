import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/core/modules/local/app_local.dart';
import 'package:techtalk/features/topic/topic.dart';

final class TopicDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator
      ..registerLazySingleton<TopicLocalDataSource>(
        () => TopicLocalDataSourceImpl(AppLocal.qnasBox),
      )
      ..registerLazySingleton<TopicRemoteDataSource>(
        TopicRemoteDataSourceImpl.new,
      );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<TopicRepository>(
      () => TopicRepositoryImpl(
        topicLocalDataSource,
        topicRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    locator
      ..registerFactory(
        () => GetTopicQnasUseCase(
          topicRepository,
        ),
      )
      ..registerFactory(
        () => UpdateWrongAnswerUseCase(topicRepository),
      )
      ..registerFactory(
        () => GetWrongAnswersUseCase(topicRepository),
      );
  }
}
