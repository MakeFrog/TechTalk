import 'package:techtalk/presentation/pages/my_info/profile_setting/providers/picked_profile_img.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

sealed class ProfileSettingProvider {
  ProfileSettingProvider._();

  static final pickedProfileImg = pickedProfileImgProvider;
  static final user = userDataProvider;
}
