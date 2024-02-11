import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/local_storage/app_local.dart';
import 'package:techtalk/features/topic/data_source/local/topic_local_data_source_impl.dart';
import 'package:techtalk/features/topic/data_source/remote/topic_remote_data_source_impl.dart';
import 'package:techtalk/features/topic/repositories/topic_repository_impl.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/topic/usecases/update_wrong_answer_use_case.dart';

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
        GetTopicsUseCase.new,
      )
      ..registerFactory(
        () => GetCategorizedTopicsUseCase(
          topicRepository,
        ),
      )
      ..registerFactory(
        () => GetTopicQnasUseCase(
          topicRepository,
        ),
      )
      ..registerFactory(
        () => UpdateWrongAnswerUseCase(topicRepository),
      );
  }
}
