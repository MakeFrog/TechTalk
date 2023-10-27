import 'package:get_it/get_it.dart';
import 'package:techtalk/features/tech_skill/data/remote/tech_skill_remote_data_source.dart';
import 'package:techtalk/features/tech_skill/repositories/tech_skill_repository.dart';
import 'package:techtalk/features/tech_skill/usecases/search_tech_skill_list_use_case.dart';

export 'data/remote/tech_skill_remote_data_source.dart';
export 'entities/tech_skill_entity.dart';
export 'repositories/tech_skill_repository.dart';
export 'usecases/search_tech_skill_list_use_case.dart';

final techSkillRemoteDataSource = GetIt.I<TechSkillRemoteDataSource>();
final techSkillRepository = GetIt.I<TechSkillRepository>();
final searchTechSkillListUseCase = GetIt.I<SearchTechSkillListUseCase>();
