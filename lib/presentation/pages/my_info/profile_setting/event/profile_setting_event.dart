import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/pages/my_info/profile_setting/providers/profile_setting_providers.dart';

mixin class ProfileSettingEvent {
  void onProfileImgTapped(WidgetRef ref) {
    ref.read(ProfileSettingProvider.pickedProfileImg.notifier).pickImageFile();
  }
}
