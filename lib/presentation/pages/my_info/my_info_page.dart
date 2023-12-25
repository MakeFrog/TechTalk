import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/presentation/pages/my_info/widgets/card_list_tile_button.dart';
import 'package:techtalk/presentation/pages/my_info/widgets/expandable_wrapped_list_view.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/image/round_profile_image.dart';

part 'widgets/additional_info_card.dart';
part 'widgets/intro_text_view.dart';
part 'widgets/my_info_page_scaffold.dart';
part 'widgets/setting_card.dart';
part 'widgets/user_info_card.dart';

class MyInfoPage extends BasePage {
  const MyInfoPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return const _Scaffold(
      introView: _IntroView(),
      myInfoCard: _UserInfoCard(),
      settingCard: _SettingCard(),
      additionalInfoCard: _AdditionalInfoCard(),
    );
  }

  @override
  Color? get screenBackgroundColor => AppColor.of.background1;

  @override
  Color? get unSafeAreaColor => AppColor.of.background1;
}
