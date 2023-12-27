import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/features/system/data/remote/system_remote_data_source.dart';
import 'package:techtalk/features/system/repositories/system_repository.dart';
import 'package:techtalk/features/system/use_cases/get_version_info_use_case.dart';

export 'data/model/version_model.dart';
export 'data/remote/system_remote_data_source.dart';
export 'data/remote/system_remote_data_source_impl.dart';
export 'entities/version_entity.dart';
export 'repositories/system_repository.dart';
export 'repositories/system_repository_impl.dart';
export 'system.dart';
export 'use_cases/get_version_info_use_case.dart';

final systemRemoteDataSource = locator<SystemRemoteDataSource>();
final systemRepository = locator<SystemRepository>();
final getVersionInfoUseCase = locator<GetVersionInfoUseCase>();
