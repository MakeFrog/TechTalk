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
import 'package:techtalk/features/chat/repositories/entities/proficiency_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/follow_up_status.enum.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_result.dart';
import 'package:techtalk/features/topic/repositories/entities/common_qna_entity.dart';
import 'package:techtalk/presentation/pages/interview/chat/chat_state.dart';
import 'package:techtalk/presentation/pages/interview/chat/widgets/qna_detail_box.dart';
import 'package:techtalk/presentation/widgets/common/chip/resume_question_type_chip.dart';
import 'package:techtalk/presentation/widgets/common/indicator/response_indicator.dart';
import 'package:techtalk/presentation/widgets/common/tile/flexible_expansion_tile.dart';

class QnaExpansionTile extends HookConsumerWidget with ChatState {
  const QnaExpansionTile(this.item, {Key? key}) : super(key: key);

  final ChatQnaEntity item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpen = useState<bool>(false);

    // readRoom(ref).type.typedBranch(
    //       common: (_) {
    //         item.qna
    //       },
    //       resume: (_) {},
    //     );

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
              Wrap(
                children: [
                  if (readRoom(ref).type.isResume)
                    ResumeQuestionTypeChip(
                      type: (item.qna as ResumeQnaEntity).questionType,
                      margin: const EdgeInsets.only(
                        right: 6,
                      ),
                    ),
                  ResponseIndicator(
                    followupStatus: item.followUpQna != null
                        ? FollowupStatus.yes
                        : FollowupStatus.no,
                    chatResult: item.message!.answerState.isCorrect
                        ? InterviewResult.pass
                        : InterviewResult.failed,
                    text: item.message!.answerState.isCorrect
                        ? context.tr(LocaleKeys.common_responseResult_correct)
                        : context
                            .tr(LocaleKeys.common_responseResult_incorrect),
                  ),
                ],
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
            QnaDetailBox(
              title: tr(LocaleKeys.qa_myAnswer),
              descriptions: [item.message!.message.value],
            ),

            /// 단골 질문 인터뷰
            /// => 모범 답변
            item.qna.type.branch(
              common: (_) {
                final targetQna = item.qna as CommonQnaEntity;
                return QnaDetailBox(
                  title: tr(LocaleKeys.qa_modelAnswer),
                  descriptions: targetQna.answers,
                );
              },
              resume: (_) {
                final targetQna = item.qna as ResumeQnaEntity;
                return QnaDetailBox(
                  title: tr(LocaleKeys.interview_evaluation_title),
                  descriptions: [targetQna.evaluationPoint],
                );
              },
              youtube: (_) {
                final targetQna = item.qna as YoutubeQnaEntity;
                return QnaDetailBox(
                  title: tr(LocaleKeys.qa_modelAnswer),
                  descriptions: [targetQna.answer],
                );
              },
              proficiency: (_) {
                final targetQna = item.qna as ProficiencyQnaEntity;
                return QnaDetailBox(
                  title: tr(LocaleKeys.qa_modelAnswer),
                  descriptions: targetQna.answers,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
