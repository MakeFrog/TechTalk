import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/profile_setting_type.enum.dart';
import 'package:techtalk/core/helper/global_event_key.dart';
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
                ProfileSettingRoute().go(context);
              },
              jobGroup: (_) {
                JobGroupSettingRoute().go(context);
              },
              topic: (_) {
                SkillSettingRoute().go(context);
              },
            );
          },
        );
      },
    );
  }

  ///
  /// [ExpandableWrappedListview]
  /// Wrap위젯이 overflow 되었을 때,
  /// 첫 번째 행의 끝 위치와
  /// 마지막 행의 끝 위치를 구하는 메소드
  ///
  void getListItemPosition(
      List<({String text, GlobalKey key})> itemCollection,
      ValueNotifier<double> firstRowElementY,
      ValueNotifier<double> lastRowElementY,
      double spacing) {
    int firstRowElementCount = 0;
    int lastRowElementCount = 0;
    final firstRowY = itemCollection[0].key.top;
    final lastRowY = itemCollection.last.key.top;

    for (var e in itemCollection) {
      if (e.key.top == firstRowY) {
        firstRowElementY.value += e.key.width;
        firstRowElementCount++;
      } else {
        if (e.key.top == lastRowY) {
          lastRowElementY.value += e.key.width;
          lastRowElementCount++;
        }
      }
    }

    if (firstRowElementCount > 0) {
      firstRowElementY.value += spacing * (firstRowElementCount - 1);
    }

    if (lastRowElementCount > 0) {
      lastRowElementY.value += spacing * (lastRowElementCount - 1);
    }
  }

  ///
  /// [ExpandableWrappedListview]
  /// 상단에 위치한 [Wrap]의 자체 크기를
  /// 확인하여, overflow가 되었는지 계산하는 메소드
  ///
  void getWrapWidgetSize(BuildContext context, ValueNotifier<Size> notifier,
      ValueNotifier<double> originHeight) {
    notifier.value = (context.findRenderObject() as RenderBox).size;
    originHeight.value = notifier.value.height;
  }
}