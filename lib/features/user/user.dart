import 'package:techtalk/app/di/app_binding.dart';
import 'package:techtalk/features/user/data_source/local/user_local_data_source.dart';
import 'package:techtalk/features/user/data_source/remote/user_remote_data_source.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';
import 'package:techtalk/features/user/usecases/check_nickname_duplication.dart';
import 'package:techtalk/features/user/usecases/create_user_use_case.dart';
import 'package:techtalk/features/user/usecases/disable_review_available_state_use_case.dart';
import 'package:techtalk/features/user/usecases/edit_user_profile_use_case.dart';
import 'package:techtalk/features/user/usecases/get_user_use_case.dart';
import 'package:techtalk/features/user/usecases/increase_completed_interview_count_use_case.dart';
import 'package:techtalk/features/user/usecases/resign_user_info_use_case.dart';
import 'package:techtalk/features/user/usecases/sotre_user_local_info_use_case.dart';
import 'package:techtalk/features/user/usecases/update_last_login_date_use_cae.dart';
import 'package:techtalk/features/user/usecases/update_user_use_case.dart';

export 'data_source/local/boxes/user_box.dart';
export 'data_source/local/user_local_data_source.dart';
export 'data_source/local/user_local_data_source_impl.dart';
export 'data_source/remote/fire_storage_user_ref.dart';
export 'data_source/remote/models/user_model.dart';
export 'data_source/remote/user_remote_data_source.dart';
export 'data_source/remote/user_remote_data_source_impl.dart';
export 'data_source/remote/users_ref.dart';
export 'repositories/entities/user_entity.dart';
export 'repositories/user_repository.dart';
export 'repositories/user_repository_impl.dart';
export 'usecases/check_nickname_duplication.dart';
export 'usecases/create_user_use_case.dart';
export 'usecases/disable_review_available_state_use_case.dart';
export 'usecases/edit_user_profile_use_case.dart';
export 'usecases/get_user_use_case.dart';
export 'usecases/increase_completed_interview_count_use_case.dart';
export 'usecases/resign_user_info_use_case.dart';
export 'usecases/sotre_user_local_info_use_case.dart';
export 'usecases/update_last_login_date_use_cae.dart';
export 'usecases/update_user_use_case.dart';
export 'user.dart';

final userLocalDataSource = locator<UserLocalDataSource>();
final userRemoteDataSource = locator<UserRemoteDataSource>();
final userRepository = locator<UserRepository>();
final editUserProfileUseCase = locator<EditUserProfileUseCase>();
final checkIsNicknameIsDuplicated = locator<CheckNicknameDuplication>();
final createUserUseCase = locator<CreateUserUseCase>();
final updateUserUseCase = locator<UpdateUserUseCase>();
final getUserUseCase = locator<GetUserUseCase>();
final resignUserInfoUseCase = locator<ResignUserInfoUseCase>();
final storeUserLocalInfo = locator<StoreUserLocalInfoUseCase>();
final updateLastLoginDateUseCase = locator<UpdateLastLoginDateUseCase>();
final increaseCompletedInterviewCountUseCase =
    locator<IncreaseCompletedInterviewCountUseCase>();
final disableReviewAvailableStateUseCase =
    locator<DisableReviewAvailableStateUseCase>();
