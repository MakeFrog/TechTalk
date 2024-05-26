import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/services/size_service.dart';
import 'package:techtalk/presentation/pages/my_info/profile_setting/profile_setting_event.dart';
import 'package:techtalk/presentation/pages/my_info/profile_setting/profile_setting_state.dart';
import 'package:techtalk/presentation/pages/my_info/profile_setting/providers/picked_profile_img.dart';
import 'package:techtalk/presentation/providers/input/nickname_input_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/gesture/animated_scale_tap.dart';
import 'package:techtalk/presentation/widgets/common/image/round_profile_image.dart';
import 'package:techtalk/presentation/widgets/common/input/clearable_text_field.dart';

part 'widgets/nickname_input_field.dart';
part 'widgets/profile_img_button.dart';
part 'widgets/save_button.dart';

class ProfileSettingPage extends BasePage
    with ProfileSettingState, ProfileSettingEvent {
  const ProfileSettingPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          const _ProfileImgButton(),
          const Gap(40),
          _NicknameInputField(formKey),
          const Spacer(),
          _SaveButton(formKey),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();
}
