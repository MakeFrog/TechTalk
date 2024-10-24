import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/index.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

class Bubble extends StatelessWidget {
  const Bubble({
    Key? key,
    required this.chat,
    required this.isLatestReceivedChatInEachSection,
    required this.interviewer,
    required this.onReportBtnTapped,
  }) : super(key: key);

  /// 채팅 정보
  final BaseChatEntity chat;

  /// 아바타
  final Interviewer interviewer;

  /// '받은' 채팅중 가장 최신 상태 여부 (문제 섹션 단위)
  final bool isLatestReceivedChatInEachSection;

  final VoidCallback onReportBtnTapped;

  @override
  Widget build(BuildContext context) {
    /// RECEIVED CHAT
    if (chat.type.isReceivedMessage) {
      final item = chat;
      return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// INTERVIEWER CHARACTER (TALK TALK)
            Container(
              height: 32,
              width: 32,
              margin: const EdgeInsets.only(right: 8),
              child: isLatestReceivedChatInEachSection
                  ? ClipOvalCircleAvatar.create(
                      svgPath: interviewer.iconPath,
                      size: 32,
                    )
                  : const EmptyBox(),
            ),
            Container(
              margin: isLatestReceivedChatInEachSection
                  ? const EdgeInsets.only(
                      bottom: 8,
                    )
                  : null,
              constraints: BoxConstraints(maxWidth: AppSize.ratioWidth(250)),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: chat.type.isQuestionMessage
                      ? ((chat as QuestionChatEntity).isFollowUpQuestion
                          ? const Color(0xFFF4EDFF)
                          : AppColor.of.blue1)
                      : AppColor.of.blue1,
                  borderRadius: radiusOnCase,
                ),
                child: Builder(
                  builder: (BuildContext context) {
                    if (item.isStreamApplied) {
                      /// STREAMED MESSAGE
                      return HookBuilder(
                        builder: (context) {
                          useAutomaticKeepAlive();

                          return StreamBuilder<String>(
                            stream: item.message.stream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                if (chat.type.isQuestionMessage &&
                                    (chat as QuestionChatEntity)
                                        .isFollowUpQuestion) {
                                  return Text(
                                    tr(LocaleKeys.interview_loadingFollowUpQuestion),
                                    style: AppTextStyle.body2
                                        .copyWith(color: AppColor.of.gray4),
                                  )
                                      .animate(
                                          delay: 320.ms,
                                          onPlay: (controller) =>
                                              controller.repeat(
                                                  period: 500.milliseconds))
                                      .shimmer(
                                          color: Colors.white.withOpacity(0.5));
                                } else {
                                  return SizedBox(
                                    height: 17,
                                    width: 17,
                                    child: CircularProgressIndicator(
                                      color: AppColor.of.gray3,
                                      strokeWidth: 2,
                                    ),
                                  );
                                }
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.none) {
                                return Text(
                                  '오류가 발생했어요',
                                  style: AppTextStyle.alert2,
                                );
                              }

                              return Text(
                                snapshot.hasData ? snapshot.requireData : '',
                                style: AppTextStyle.body2,
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return Text(
                        item.message.valueOrNull ?? '알 수 없는 메세지 입니다',
                        style: AppTextStyle.body2,
                      );
                    }
                  },
                ),
              ),
            ),
            if (item is FeedbackChatEntity && item.message.isClosed)
              Row(
                children: [
                  const Gap(5),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppColor.of.red1,
                      shape: BoxShape.circle,
                    ),
                    child: Consumer(
                      builder: (context, ref, child) {
                        return IconFlashAreaButton.assetIcon(
                          iconPath: Assets.iconsWarning,
                          size: 10,
                          onIconTapped: onReportBtnTapped,
                        );
                      },
                    ),
                  ),
                ],
              )
            else
              const EmptyBox(),
          ],
        ),
      );
    } else {
      /// SENT CHAT
      final item = chat as AnswerChatEntity;
      return Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: AppSize.ratioWidth(250)),
              decoration: BoxDecoration(
                color: AppColor.of.background1,
                borderRadius: radiusOnCase,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                child: Text(
                  item.message.value,
                  style: AppTextStyle.body2.copyWith(color: AppColor.of.black),
                ),
              ),
            ),
            const Gap(8),
            Builder(
              /// ANSWER STATE INDICATOR
              builder: (context) {
                switch (item.answerState) {
                  case AnswerState.correct:
                    return Wrap(
                      children: [
                        Text(
                          tr(item.answerState.str),
                          style: AppTextStyle.alert1
                              .copyWith(color: AppColor.of.blue2),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        SvgPicture.asset(Assets.iconsRoundedCheckSmallBlue),
                      ],
                    );
                  case AnswerState.inappropriate:
                  case AnswerState.wrong:
                    return Wrap(
                      children: [
                        Text(
                          tr(item.answerState.str),
                          style: AppTextStyle.alert1
                              .copyWith(color: AppColor.of.red2),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        SvgPicture.asset(Assets.iconsRoundedCloseSmallRed),
                      ],
                    );

                  case AnswerState.loading:
                    return SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        color: AppColor.of.gray3,
                        strokeWidth: 1.6,
                      ),
                    );
                  default:
                    return const SquareBox(16);
                }
              },
            ),
          ],
        ),
      );
    }
  }

  /// 채팅 유형과 상태에 따라 적절한 BorderRadius값 반환
  BorderRadiusGeometry get radiusOnCase {
    // 보낸 메세지
    if (chat.type.isSentMessage) {
      return const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(2),
        bottomLeft: Radius.circular(20),
      );
    }
    // 받은 메세지 + 각 문제 섹션에서 가장 마지막 메세지
    else if (chat.type.isReceivedMessage && isLatestReceivedChatInEachSection) {
      return const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(2),
      );
    }
    // 그외에 받은 메세지
    else {
      return BorderRadius.circular(20);
    }
  }
}
