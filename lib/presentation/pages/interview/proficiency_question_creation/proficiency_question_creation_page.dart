import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_question_creation/constant/proficiency_question_creation_route_arg.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_question_creation/proficiency_question_creation_state.dart';
import 'package:techtalk/presentation/pages/interview/proficiency_question_creation/provider/proficiency_question_creation_route_arg_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

///
/// 역량별 면접 질문을 선택하는 페이지
///
class ProficiencyQuestionCreationPage extends BasePage
    with ProficiencyQuestionCreationState {
  const ProficiencyQuestionCreationPage(this.arg, {super.key});

  final ProficiencyQuestionCreationRouteArg arg;

  @override
  Override? get argProviderOverrides =>
      proficiencyRouteArgProvider.overrideWithValue(arg);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(16),
        Consumer(
          builder: (context, ref, child) {
            return FutureBuilder<String?>(
              future: nicknameFuture(ref),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                final nickname = snapshot.data ?? '익명';
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '잠시만요 $nickname님,\n질문을 생성하고 있어요',
                    style: AppTextStyle.headline1,
                  ),
                );
              },
            );
          },
        ),
        const Spacer(
          flex: 104,
        ),
        Center(
          child: Transform.scale(
            scale: 1.28, // 로티를 그대로 적용하면 디자인 시안과 안맞기 위해 임의로 scale를 줌
            child: Lottie.asset(
              Assets.lottieDocumentLoading,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        const Spacer(
          flex: 166,
        ),
      ],
    );
  }

  @override
  bool get wrapWithSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      const BackButtonAppBar();
}
