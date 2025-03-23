import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/resume/resume_manage_event.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class ResumeRegistGuidePage extends BasePage with ResumeManageEvent {
  const ResumeRegistGuidePage({super.key});

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
                '아직 이력서가 없어요\n이력서를 등록해 주세요',
                style: AppTextStyle.headline2,
              ),
              const Gap(12),
              Text(
                // TODO: 유저 이름 넣기
                '이력서로 만든 예상 질문을 경험해 보세요!',
                style: AppTextStyle.body1.copyWith(color: AppColor.of.gray4),
              ),
              const Gap(72),
              Image.asset(Assets.imagesDocumentIllustration),
            ],
          ),
          const Spacer(),
    
          // 이력서 등록하기
          BounceTapper(
            child: FilledButton(
              onPressed: () => routeToResumeUploadPage(ref),
              child: const Center(
                child: Text(
                  '이력서 등록하기',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar(title: '');
}
