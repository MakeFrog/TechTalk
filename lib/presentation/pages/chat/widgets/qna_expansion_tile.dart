import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/chat/entities/interview_qna_entity.dart';
import 'package:techtalk/presentation/widgets/common/box/empty_box.dart';
import 'package:techtalk/presentation/widgets/common/text/bullet_text.dart';
import 'package:techtalk/presentation/widgets/common/tile/flexible_expansion_tile.dart';

class QnAExpansionTile extends HookWidget {
  const QnAExpansionTile(this.item, {Key? key}) : super(key: key);

  final InterviewQnAEntity item;

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
                item.response!.state.isCorrect
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
          const HeightBox(12),

          /// QUESTION
          Text(
            item.question,
            textAlign: TextAlign.start,
            style: AppTextStyle.title1,
          ),
          const HeightBox(8),
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
            const HeightBox(6),

            /// USER ANSWER RESPONSE
            BulletText(
              item.response!.text,
              style: AppTextStyle.alert2,
            ),
            const HeightBox(18),
            Text(
              '모범 답변',
              style: AppTextStyle.alert1.copyWith(color: AppColor.of.black),
            ),
            const HeightBox(6),

            /// LIST OF IDEAL ANSWER
            ...List.generate(
              item.idealAnswer!.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: BulletText(
                  'Self는 프로토콜에서 사용되면 프로토콜을 채택하는 타입을 의미하고, 클래스, 구조체, 열거형에서 사용되면 선언에 사용된 타입을 의미합니다.',
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
