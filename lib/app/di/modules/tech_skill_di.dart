import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/tech_skill/data/remote/tech_skill_remote_data_source_impl.dart';
import 'package:techtalk/features/tech_skill/repositories/tech_skill_repository_impl.dart';
import 'package:techtalk/features/tech_skill/tech_skill.dart';

final class TechSkillDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    locator.registerLazySingleton<TechSkillRemoteDataSource>(
      TechSkillRemoteDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    final techSkillRemoteDataSource = locator<TechSkillRemoteDataSource>();

    locator.registerLazySingleton<TechSkillRepository>(
      () => TechSkillRepositoryImpl(
        techSkillRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    final techSkillRepository = locator<TechSkillRepository>();

    locator.registerFactory<SearchTechSkillListUseCase>(
      () => SearchTechSkillListUseCase(
        techSkillRepository,
      ),
    );
  }
}
