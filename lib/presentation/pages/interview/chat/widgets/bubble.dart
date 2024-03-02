import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/interviewer_entity.dart';
import 'package:techtalk/presentation/widgets/common/avatar/clip_oval_circle_avatar.dart';
import 'package:techtalk/presentation/widgets/common/button/icon_flash_area_button.dart';
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
  final ChatMessageEntity chat;

  /// 아바타
  final InterviewerEntity interviewer;

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
              constraints: const BoxConstraints(maxWidth: 250),
              child: Builder(
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.of.blue1,
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
                                    return SizedBox(
                                      height: 17,
                                      width: 17,
                                      child: CircularProgressIndicator(
                                        color: AppColor.of.gray3,
                                        strokeWidth: 2,
                                      ),
                                    );
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.none) {
                                    return Text(
                                      '오류가 발생했어요',
                                      style: AppTextStyle.alert2,
                                    );
                                  }

                                  return Text(
                                    snapshot.requireData,
                                    style: AppTextStyle.alert2,
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          /// STATIC MESSAGE
                          return Text(
                            item.message.valueOrNull ?? '알 수 없는 메세지 입니다',
                            style: AppTextStyle.alert2,
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            if (item is FeedbackChatMessageEntity && item.message.isClosed)
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
              EmptyBox(),
          ],
        ),
      );
    } else {
      /// SENT CHAT
      final item = chat as AnswerChatMessageEntity;
      return Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 250),
              decoration: BoxDecoration(
                color: AppColor.of.background1,
                borderRadius: radiusOnCase,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                child: Text(
                  item.message.value,
                  style: AppTextStyle.alert2.copyWith(color: AppColor.of.black),
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
                          '정답',
                          style: AppTextStyle.alert1
                              .copyWith(color: AppColor.of.blue2),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        SvgPicture.asset(Assets.iconsRoundedCheckSmallBlue),
                      ],
                    );
                  case AnswerState.wrong:
                    return Wrap(
                      children: [
                        Text(
                          '오답',
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
