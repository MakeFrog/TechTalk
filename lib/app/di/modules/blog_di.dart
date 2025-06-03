import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtalk/features/blog/data_sources/remote/blog_remote_data_source.dart';
import 'package:techtalk/features/blog/data_sources/remote/blog_remote_data_source_impl.dart';
import 'package:techtalk/features/blog/repository/blog_repository.dart';
import 'package:techtalk/features/blog/repository/blog_repository_impl.dart';
import 'package:techtalk/features/blog/use_case/get_blog_contents_use_case.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

final class BlogContentsDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(FirebaseFirestore.instance),
    );
  }

  @override
  void repositories() {
    locator.registerLazySingleton<BlogRepository>(
      () => BlogRepositoryImpl(
        locator<BlogRemoteDataSource>(),
        locator<TechSetRepository>(),
      ),
    );
  }

  @override
  void useCases() {
    locator
      ..registerFactory(
        () => GetBlogOverviewListUseCase(
          locator<BlogRepository>(),
        ),
      );
  }
}
