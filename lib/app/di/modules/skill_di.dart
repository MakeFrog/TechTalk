import 'package:get_it/get_it.dart';
import 'package:techtalk/app/di/feature_di_interface.dart';
import 'package:techtalk/features/skill/data/remote/skill_remote_data_source_impl.dart';
import 'package:techtalk/features/skill/repositories/skill_repository_impl.dart';
import 'package:techtalk/features/skill/skill.dart';

final class TechSkillDependencyInjection extends FeatureDependencyInjection {
  @override
  void dataSources() {
    GetIt.I.registerLazySingleton<SkillRemoteDataSource>(
      SkillRemoteDataSourceImpl.new,
    );
  }

  @override
  void repositories() {
    GetIt.I.registerLazySingleton<SkillRepository>(
      () => SkillRepositoryImpl(
        skillRemoteDataSource,
      ),
    );
  }

  @override
  void useCases() {
    GetIt.I.registerFactory<SearchSkillsUseCase>(
      () => SearchSkillsUseCase(
        skillRepository,
      ),
    );
  }
}
