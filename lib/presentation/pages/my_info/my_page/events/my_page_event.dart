import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/profile_setting_type.enum.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';
import 'package:techtalk/presentation/widgets/common/bottom_sheet/option_list_bottom_sheet.dart';

mixin class MyPageEvent {
  ///
  /// 개인정보 및 약관 사이트로 이동
  ///
  void onVisitPolicyPageBtnTapped() {}

  ///
  /// 피드백 및 문의사항 페이지로 이동
  ///
  void onVisitCsPageTapped() {}

  ///
  /// 로그아웃
  ///
  void onLogOutBtnTapped() {}

  ///
  /// 회원탈퇴
  ///
  void onWithdrawalBtnTapped() {}

  ///
  /// 설정 bottom sheet 모달창 노출
  ///
  void onProfileEditBtnTapped(WidgetRef ref) {
    showModalBottomSheet(
      context: ref.context,
      useSafeArea: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return OptionListBottomSheet(
          leadingText: '내 정보 수정',
          onCloseBtnTapped: context.pop,
          options: ProfileSettingType.values.map((e) => e.name).toList(),
          onOptionTapped: (int index) {
            ProfileSettingType.branch(
              targetCategory: ProfileSettingType.getByIndex(index),
              profile: (_) {
                final user = ref.read(userDataProvider).value;
                ProfileSettingRoute(user!).go(context);
              },
              jobGroup: (_) {
                // JobGroupSettingRoute().go(context);
              },
              topic: (_) {},
            );
          },
        );
      },
    );
  }
}
