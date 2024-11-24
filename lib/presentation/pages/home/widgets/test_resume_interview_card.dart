import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/home/home_event.dart';
import 'package:techtalk/presentation/pages/home/widgets/home_state.dart';

class TestResumeInterviewCard extends ConsumerWidget with HomeState, HomeEvent {
  const TestResumeInterviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 임시 프롬프팅 파라미터
    const String resumeOrPortfolioContent = '''
저는 5년 이상의 Flutter 개발 경험이 있으며, riverpod와 provider를 활용한 상태 관리에 능숙합니다. GoRouter를 사용하여 복잡한 내비게이션 구조를 구현한 경험이 있고, 3개의 Flutter 앱을 성공적으로 출시하여 앱 스토어에서 긍정적인 평가를 받았습니다.

또한, RESTful API와 GraphQL을 활용한 백엔드 연동 경험이 있으며, Firebase를 이용한 인증 및 데이터베이스 관리에 익숙합니다. 팀 협업을 위한 Git 및 CI/CD 파이프라인 구축 경험도 가지고 있습니다.

UI/UX 디자인에도 관심이 많아 Material Design과 Cupertino 디자인 가이드를 준수하여 사용자 친화적인 인터페이스를 구현할 수 있습니다. 문제 해결 능력이 뛰어나며, 새로운 기술을 학습하고 적용하는 데 적극적입니다.
''';

    return BounceTapper(
      onTap: () {
        testSetAiResumeQuestionUseCase(
          isFile: false,
          resumeOrPortfolioContent: resumeOrPortfolioContent,
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
        decoration: BoxDecoration(
          color: AppColor.of.brand1,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '이력서 프롬프트 실험 버튼\n(Print 출력)',
                    style: AppTextStyle.headline2.copyWith(
                      color: AppColor.of.brand3,
                    ),
                  ),
                ),
                BounceTapper(
                  highlightColor: Colors.transparent,
                  onTap: () {
                    /// 임시 로직
                    // routeToChatPage(
                    //   ref,
                    //   type: InterviewType.resume,
                    //   topics: [],
                    // );
                  },
                  child: SvgPicture.asset(Assets.iconsRoundBlueCircle),
                ),
              ],
            ),
            if (!(user(ref)?.hasPracticalInterviewRecord ?? false))
              Padding(
                padding: const EdgeInsets.only(bottom: 12, right: 24),
                child: Text(
                  '이력서를 첨부하여 면접을 시작해보세요!',
                  style: AppTextStyle.body1.copyWith(
                    color: AppColor.of.gray3,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
