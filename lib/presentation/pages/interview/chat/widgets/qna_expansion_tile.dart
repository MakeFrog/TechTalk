import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/chat_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/follow_up_status.enum.dart';
import 'package:techtalk/features/chat/repositories/enums/chat_result.enum.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/widgets/common/indicator/response_indicator.dart';
import 'package:techtalk/presentation/widgets/common/tile/flexible_expansion_tile.dart';

class QnAExpansionTile extends HookConsumerWidget with ChatState {
  const QnAExpansionTile(this.item, {Key? key}) : super(key: key);

  final ChatQnaEntity item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpen = useState<bool>(false);

    return FlexibleExpansionTile(
      isExpanded: isOpen,
      padding: const EdgeInsets.only(bottom: 16, top: 24) +
          const EdgeInsets.symmetric(horizontal: 16),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// CORRECT WRONG INDICATOR

              ResponseIndicator(
                followupStatus: item.followUpQna != null
                    ? FollowupStatus.yes
                    : FollowupStatus.no,
                chatResult: item.message!.answerState.isCorrect
                    ? ChatResult.pass
                    : ChatResult.failed,
                text: item.message!.answerState.isCorrect
                    ? context.tr(LocaleKeys.common_responseResult_correct)
                    : context.tr(LocaleKeys.common_responseResult_incorrect),
              ),
              AnimatedRotation(
                turns: isOpen.value ? 0 : 0.5,
                duration: const Duration(milliseconds: 240),
                child: SvgPicture.asset(
                  Assets.iconsExpansionArrowIndicator,
                ),
              ),
            ],
          ),
          const Gap(12),

          /// QUESTION
          Text(
            '${room(ref).type.isPractical ? '${StoredTopics.getById(item.qna.id.getFirstPartOfSpliited).text} : ' : ''}${item.qna.question}',
            textAlign: TextAlign.start,
            style: AppTextStyle.title1,
          ),
          const Gap(8),
        ],
      ),
      content: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// 내 답변
            _buildAnswerContainer(
              backgroundColor: AppColor.of.brand5,
              title: tr(LocaleKeys.qa_myAnswer),
              children: [
                Text(
                  item.message!.message.value,
                  style: AppTextStyle.body3,
                ),
              ],
            ),

            /// 모범 답변
            _buildAnswerContainer(
              backgroundColor: AppColor.of.brand5,
              title: tr(LocaleKeys.qa_modelAnswer),
              children: List.generate(
                item.qna.answers.length,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        item.qna.answers[index],
                        style: AppTextStyle.body3,
                      ),
                    ),
                    if (index != item.qna.answers.length - 1)
                      Divider(
                        thickness: 0.7,
                        color: AppColor.of.gray1,
                        height: 24,
                      ),
                  ],
                ),
              ),
            ),

            // TODO : 꼬리질문 기능 구현시 적용할 예정
            if (item.followUpQna?.question != null)
              _buildAnswerContainer(
                backgroundColor: AppColor.of.purple1,
                title: '꼬리 질문',
                showIndicator: true,
                children: [
                  Text(
                    item.followUpQna!.question!,
                    style: AppTextStyle.body3,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // 공통된 레이아웃 위젯
  Widget _buildAnswerContainer({
    required Color backgroundColor,
    required String title,
    required List<Widget> children,
    bool showIndicator = false,
    String? iconIndicatorPath,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목 텍스트
          Row(
            children: [
              Text(
                title,
                style: AppTextStyle.body1,
              ),
              const Gap(2),
              if (showIndicator)
                SvgPicture.asset(iconIndicatorPath ?? Assets.iconsStarDeco),
            ],
          ),
          const Gap(6),
          // 내용
          ...children,
        ],
      ),
    );
  }
}
