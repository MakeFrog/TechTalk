import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_event.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_state.dart';
import 'package:techtalk/presentation/widgets/base/index.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

class InterviewLoadingPage extends BasePage
    with ResumeEvent, ResumeState {
  InterviewLoadingPage({super.key});

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final lottieAnimationController = useAnimationController(
      duration: 2.seconds,
    );

    useEffect(
      () {
        lottieAnimationController.loop(
          reverse: true,
        );

        return () {};
      },
      [],
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '잠시만요, ${user(ref)?.nickname ?? ''}님\n면접관이 이력서를 읽고 있어요',
            style: AppTextStyle.headline1,
          ),
          const Gap(104),

          // Lottie 크기를 지정
          SizedBox(
            width: double.infinity,
            child: Lottie.asset(
              'assets/lottie/document_loading.json',
              controller: lottieAnimationController,
              onLoaded: (composition) {
                lottieAnimationController
                  ..duration = composition.duration
                  ..repeat();
              },
            ),
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
