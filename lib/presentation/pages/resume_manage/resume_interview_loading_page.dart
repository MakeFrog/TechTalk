import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_event.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_state.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

class ResumeInterviewLoadingPage extends BasePage
    with ResumeManageEvent, ResumeManageState {
  ResumeInterviewLoadingPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                // TODO: 유저 이름 가져오기 (yundal)
                '잠시만요,\n면접관이 이력서를 읽고 있어요',
                style: AppTextStyle.headline2,
              ),
              const Gap(104),
              Image.asset(Assets.imagesAnalyzingMan),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      BackButtonAppBar(
        title: '',
        onBackBtnTapped: () => DialogService.show(
          dialog: AppDialog.dividedBtn(
            title: '정말 나가시겠습니까?',
            subTitle: '준비중인 면접 질문은 사라집니다',
            leftBtnContent: '확인',
            rightBtnContent: '취소',
            showContentImg: false,
            onRightBtnClicked: ref.context.pop,
            onLeftBtnClicked: () => const MainRoute().go(ref.context),
          ),
        ),
      );
}
