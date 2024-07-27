import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/my_info/my_page/my_page_event.dart';
import 'package:techtalk/presentation/pages/my_info/my_page/my_page_state.dart';
import 'package:techtalk/presentation/pages/my_info/my_page/widgets/card_list_tile_button.dart';
import 'package:techtalk/presentation/pages/my_info/my_page/widgets/expandable_wrapped_list_view.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';
import 'package:techtalk/presentation/widgets/common/button/icon_flash_area_button.dart';
import 'package:techtalk/presentation/widgets/common/image/round_profile_image.dart';

part 'widgets/additional_info_card.dart';
part 'widgets/intro_view.dart';
part 'widgets/my_info_page_scaffold.dart';
part 'widgets/setting_card.dart';
part 'widgets/user_info_card.dart';

class MyPage extends BasePage {
  const MyPage({super.key});

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
