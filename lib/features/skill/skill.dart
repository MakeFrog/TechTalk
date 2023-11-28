import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/skill/data/remote/skill_remote_data_source.dart';
import 'package:techtalk/features/skill/repositories/skill_repository.dart';
import 'package:techtalk/features/skill/usecases/search_skills_use_case.dart';

export 'data/remote/skill_remote_data_source.dart';
export 'entities/skill_entity.dart';
export 'repositories/skill_repository.dart';
export 'usecases/search_skills_use_case.dart';

final skillRemoteDataSource = locator<SkillRemoteDataSource>();
final skillRepository = locator<SkillRepository>();
final searchSkillsUseCase = locator<SearchSkillsUseCase>();
