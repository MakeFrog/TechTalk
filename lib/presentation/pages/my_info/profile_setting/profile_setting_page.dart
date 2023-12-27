import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/presentation/pages/my_info/profile_setting/event/profile_setting_event.dart';
import 'package:techtalk/presentation/pages/my_info/profile_setting/providers/profile_setting_providers.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/image/round_profile_image.dart';

class ProfileSettingPage extends BasePage with ProfileSettingEvent {
  const ProfileSettingPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          /// PROFILE IMAGE
          Align(
            child: Consumer(
              builder: (context, ref, __) {
                const double imgSize = 120;

                final pickedImgFile =
                    ref.watch(ProfileSettingProvider.pickedProfileImg);

                final currentProfileImgUrl =
                    ref.read(ProfileSettingProvider.user).value?.profileImgUrl;

                /// 불러온 로컬 이미지 파일이 없다면,
                /// 현재 유저의 프로필 이미지를 노출
                if (pickedImgFile == null) {
                  return GestureDetector(
                    onTap: () {
                      onProfileImgTapped(ref);
                    },
                    child: Stack(
                      children: [
                        RoundProfileImg(
                          size: 120,
                          imgUrl: currentProfileImgUrl,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(Assets.iconsRoundedCamera),
                        )
                      ],
                    ),
                  );
                } else {
                  /// PICKED IMAGE
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(imgSize / 2),
                    child: Image.file(
                      pickedImgFile,
                      height: imgSize,
                      width: imgSize,
                      fit: BoxFit.cover,
                    ),
                  );
                }
              },
            ),
          ),

          const Spacer(),

          /// BOTTOM FIXED SAVE BUTTON
          FilledButton(
            onPressed: () {},
            child: const Center(
              child: Text('다음'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();
}
