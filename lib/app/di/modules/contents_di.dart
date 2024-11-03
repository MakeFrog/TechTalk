import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/contents/contents.dart';

final class ContentsDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    // locator
    //   ..registerLazySingleton<TopicLocalDataSource>(
    //     () => TopicLocalDataSourceImpl(AppLocal.qnasBox),
    //   )
    //   ..registerLazySingleton<TopicRemoteDataSource>(
    //     TopicRemoteDataSourceImpl.new,
    //   );
  }

  /// TODO: 추후에 다른 repository 추가 예정
  @override
  void repositories() {
    locator.registerLazySingleton<ContentsRepository>(
      () => ContentsRepositoryImpl(),
    );
  }

  @override
  void useCases() {
    locator
      ..registerFactory(
        () => GetYoutubeVideoDataUseCase(
          contentsRepository,
        ),
      );
  }
}
