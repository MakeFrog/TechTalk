import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/core/query_constraints_applier.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_remote_data_source.dart';
import 'package:techtalk/features/contents/data_source/remote/youtube_contents_remote_data_source_impl.dart';
import 'package:techtalk/features/contents/index.dart';
import 'package:techtalk/features/contents/usecases/get_youtube_overview_list_use_case.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final class YoutubeContentsDependencyInjection
    extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<YoutubeContentsRemoteDataSource>(
      () => YoutubeContentsRemoteDataSourceImpl(QueryConstraintApplier()),
    );
  }

  /// TODO: 추후에 다른 repository 추가 예정
  @override
  void repositories() {
    locator.registerLazySingleton<YoutubeContentsRepository>(
      () => YoutubeContentsRepositoryImpl(
        YoutubeExplode(),
        youtubeRemoteDataSource,
        techSetRepository,
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
        () => GetYoutubeOverviewListUseCase(
          youtubeRepository,
        ),
      );
  }
}
