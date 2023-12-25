import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  void onProfileEditBtnTapped(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return OptionListBottomSheet(
          leadingText: '내 정보 수정',
          onCloseBtnTapped: context.pop,
          options: const [
            '프로필',
            '관심 직군',
            '관심 주제',
          ],
          onOptionTapped: () {},
        );
      },
    );
  }
}
