import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/chat/entities/chat_qna_entity.dart';
import 'package:techtalk/presentation/widgets/common/text/bullet_text.dart';
import 'package:techtalk/presentation/widgets/common/tile/flexible_expansion_tile.dart';

class QnAExpansionTile extends HookWidget {
  const QnAExpansionTile(this.item, {Key? key}) : super(key: key);

  final ChatQnaEntity item;

  @override
  Widget build(BuildContext context) {
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
              SvgPicture.asset(
                item.answer!.answerState.isCorrect
                    ? Assets.iconsCorrectIndicator
                    : Assets.iconsWrongIndicator,
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
            item.question.question,
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
            Text(
              '내 답변',
              style: AppTextStyle.alert1.copyWith(color: AppColor.of.black),
            ),
            const Gap(6),

            /// USER ANSWER RESPONSE
            BulletText(
              item.answer!.message.value,
              style: AppTextStyle.alert2,
            ),
            const Gap(18),
            Text(
              '모범 답변',
              style: AppTextStyle.alert1.copyWith(color: AppColor.of.black),
            ),
            const Gap(6),

            /// LIST OF IDEAL ANSWER
            ...List.generate(
              item.question.answers.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: BulletText(
                  item.question.answers[index],
                  style: AppTextStyle.alert2,
                ),
              ),
            )

            /// USER ANSWER RESPONSE
          ],
        ),
      ),
    );
  }
}
