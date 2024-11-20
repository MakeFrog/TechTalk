import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_remote_data_source.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_remote_data_source_impl.dart';
import 'package:techtalk/features/contents/usecases/get_youtube_contents_detail_data_use_case.dart';
import 'package:techtalk/features/contents/youtube.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final class YoutubeContentsDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator
      ..registerLazySingleton<YoutubeContentsRemoteDataSource>(
        YoutubeContentsRemoteDataSourceImpl.new,
      );
  }

  /// TODO: 추후에 다른 repository 추가 예정
  @override
  void repositories() {
    locator.registerLazySingleton<YoutubeContentsRepository>(
      () => YoutubeContentsRepositoryImpl(
        YoutubeExplode(),
        youtubeRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    locator
      ..registerFactory(
        () => GetYoutubeVideoDataUseCase(
          youtubeRepository,
        ),
      )
      ..registerFactory(
        () => GetYoutubeContentsDetailDataUseCase(
          youtubeRepository,
        ),
      );
  }
}
