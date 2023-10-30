import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/common/state/keep_alive_view.dart';

class Bubble extends StatelessWidget {
  const Bubble({
    Key? key,
    required this.chat,
    required this.isLatestReceivedChatInEachSection,
  }) : super(key: key);

  /// 채팅 정보
  final ChatEntity chat;

  /// '받은' 채팅중 가장 최신 상태 여부 (문제 섹션 단위)
  final bool isLatestReceivedChatInEachSection;

  @override
  Widget build(BuildContext context) {
    /// RECEIVED CHAT
    if (chat.type.isReceivedMessage) {
      final item = chat as ReceivedChatEntity;
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
                  ? SvgPicture.asset(
                      Assets.characterBluePlus,
                      height: 32,
                      width: 32,
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
              decoration: BoxDecoration(
                color: AppColor.of.blue1,
                borderRadius: radiusOnCase,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                child: Builder(
                  builder: (BuildContext context) {
                    if (item.isStreamApplied) {
                      /// STREAMED MESSAGE
                      return KeepAliveView(
                        child: StreamBuilder<String>(
                          stream: item.message.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.requireData,
                                style: AppTextStyle.alert2,
                              );
                            } else {
                              /// LOADING INDICATOR
                              return SizedBox(
                                height: 17,
                                width: 17,
                                child: CircularProgressIndicator(
                                  color: AppColor.of.gray3,
                                  strokeWidth: 2,
                                ),
                              );
                            }
                          },
                        ),
                      );
                    } else {
                      /// STATIC MESSAGE
                      return Text(
                        item.message.value,
                        style: AppTextStyle.alert2,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      /// SENT CHAT
      final item = chat as SentChatEntity;
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
            Builder(
              /// ANSWER STATE INDICATOR
              builder: (context) {
                switch (item.answerState) {
                  case AnswerState.correct:
                    return SvgPicture.asset(Assets.iconsRoundedCheckSmallBlue);
                  case AnswerState.wrong:
                    return SvgPicture.asset(Assets.iconsRoundedCloseSmallRed);
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