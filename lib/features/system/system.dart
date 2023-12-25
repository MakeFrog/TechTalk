import 'package:techtalk/app/di/locator.dart';
import 'package:techtalk/features/system/use_cases/get_version_info_use_case.dart';

export 'data/model/version_model.dart';
export 'data/remote/system_remote_data_source.dart';
export 'data/remote/system_remote_data_source_impl.dart';
export 'repositories/entities/version_entity.dart';
export 'repositories/system_repository.dart';
export 'repositories/system_repository_impl.dart';
export 'system.dart';
export 'use_cases/get_version_info_use_case.dart';

final getVersionInfoUseCase = locator<GetVersionInfoUseCase>();
