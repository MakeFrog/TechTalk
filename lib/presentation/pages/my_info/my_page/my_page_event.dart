import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/module/app_local.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/constants/profile_setting_type.enum.dart';
import 'package:techtalk/core/helper/global_event_key.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/pages/study/learning/providers/study_answer_blur_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/wrong_answer_blur_provider.dart';
import 'package:techtalk/presentation/providers/main_bottom_navigation_provider.dart';
import 'package:techtalk/presentation/providers/user/user_auth_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:techtalk/presentation/widgets/common/bottom_sheet/option_list_bottom_sheet.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

mixin class MyPageEvent {
  ///
  /// 개인정보 및 약관 사이트로 이동
  ///
  Future<void> onVisitPolicyPageBtnTapped() async {
    await launchUrl(
      Uri.parse(
          'https://puzzle-heather-876.notion.site/649ad84bc43a4223bf2517342c89114e?pvs=25'),
      mode: LaunchMode.externalApplication,
    );
  }

  ///
  /// 피드백 및 문의사항 페이지로 이동
  ///
  Future<void> onVisitCsPageTapped() async {
    await launchUrl(
      Uri.parse('http://pf.kakao.com/_YWxoaG/chat'),
      mode: LaunchMode.externalApplication,
    );
  }

  ///
  /// 로그아웃 버튼이 클릭 되었을 때
  ///
  void onLogOutBtnTapped(WidgetRef ref) {
    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: '로그아웃',
        subTitle: '정말 로그아웃 하시겠습니까?',
        leftBtnContent: '취소',
        rightBtnContent: '로그아웃',
        showContentImg: false,
        onRightBtnClicked: () {
          _clearKeepAliveModules(ref);

          const SignInRoute().go(ref.context);
        },
        onLeftBtnClicked: ref.context.pop,
      ),
    );
  }

  ///
  /// 회원탈퇴
  ///
  void onResignBtnTapped(WidgetRef ref) {
    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: '회원탈퇴',
        subTitle: '정말 회원탈퇴 하시겠습니까?',
        leftBtnContent: '취소',
        rightBtnContent: '확인',
        showContentImg: false,
        onRightBtnClicked: () {
          ref.context.pop();
          _showResignRemindDialog(ref);
        },
        onLeftBtnClicked: ref.context.pop,
      ),
    );
  }

  ///
  /// 회원탈퇴 경고 다이어로그
  ///
  Future<void> _showResignRemindDialog(WidgetRef ref) async {
    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: '경고',
        subTitle: '회원탈퇴 시 모든 정보가 삭제되며 복구가 어렵습니다. 그래도 탈퇴 하시겠습니까?',
        leftBtnContent: '취소',
        rightBtnContent: '회원탈퇴',
        onRightBtnClicked: () async {
          await EasyLoading.show();
          final response = await resignUserInfoUseCase
              .call(ref.read(userInfoProvider).requireValue!);
          response.fold(
              onSuccess: (_) {
                _clearKeepAliveModules(ref);
                const SignInRoute().go(ref.context);
                SnackBarService.showSnackBar('회원탈퇴가 원료되었습니다');
                EasyLoading.dismiss();
              },
              onFailure: (e) {});
        },
        onLeftBtnClicked: ref.context.pop,
      ),
    );
  }

  ///
  /// Keep Alive 인스턴스 + 로컬 캐시 삭제
  ///
  void _clearKeepAliveModules(WidgetRef ref) {
    AppLocal.clearCache();

    ref.read(userAuthProvider.notifier).signOut();
    ref.invalidate(userInfoProvider);
    ref.invalidate(mainBottomNavigationProvider);
    ref.invalidate(studyAnswerBlurProvider);
    ref.invalidate(wrongAnswerBlurProvider);
  }

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
