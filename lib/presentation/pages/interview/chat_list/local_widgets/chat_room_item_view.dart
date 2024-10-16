import 'package:bounce_tapper/bounce_tapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/helper/date_time_extension.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/enums/follow_up_status.enum.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/chat_list_event.dart';
import 'package:techtalk/presentation/widgets/common/avatar/clip_oval_circle_avatar.dart';
import 'package:techtalk/presentation/widgets/common/box/skeleton_box.dart';
import 'package:techtalk/presentation/widgets/common/chip/normal_rounded_chip.dart';
import 'package:techtalk/presentation/widgets/common/indicator/response_indicator.dart';

class ChatRoomItemView extends StatelessWidget with ChatListEvent {
  const ChatRoomItemView({
    Key? key,
    required this.item,
    required this.isLoaded,
  }) : super(key: key);

  factory ChatRoomItemView.create(InterviewType type, ChatRoomEntity item) =>
      ChatRoomItemView(item: item, isLoaded: true);

  factory ChatRoomItemView.createSkeleton() =>
      const ChatRoomItemView(item: null, isLoaded: false);

  final ChatRoomEntity? item;
  final bool isLoaded;

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 16) +
            const EdgeInsets.only(top: 24, bottom: 24),
        onPressed: () {
          routeToChatPage(
            context,
            room: item!,
          );
        },
        child: SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // CHARACTER IMAGE
              ClipOvalCircleAvatar.create(
                svgPath: item!.interviewer.iconPath,
                size: 64,
              ),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: AppSize.ratioWidth(174),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CHARACTER NAME
                    Text(
                      tr(LocaleKeys.common_interviewTerms_interviewer, args: [
                        tr(item!.interviewer.name),
                      ]),
                      style: AppTextStyle.title1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const Gap(9),

                    /// LAST CHAT MESSAGE or TOPIC CHIP LIST
                    Builder(
                      builder: (context) {
                        if (item!.type.isPractical) {
                          return Wrap(
                            children: [
                              ...List.generate(
                                item!.topics.length,
                                (index) => NormalRoundedChip(
                                  margin: const EdgeInsets.only(
                                    bottom: 6,
                                    right: 6,
                                  ),
                                  text: item!.topics[index].text,
                                ),
                              )
                            ],
                          );
                        } else {
                          return Text(
                            item!.lastChatMessage ?? '',
                            style: AppTextStyle.alert2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // LAST CHAT DATE
                  Text(
                    item!.lastChatDate?.formatyyMMdd ?? '',
                    style: AppTextStyle.alert2.copyWith(
                      color: AppColor.of.gray3,
                    ),
                  ),
                  const Gap(9),
                  // PROGRESS INDICATOR
                  Builder(
                    builder: (context) {
                      switch (item!.progressState) {
                        case ChatRoomProgress.initial ||
                              ChatRoomProgress.ongoing:
                          return NormalRoundedChip(
                            text:
                                '${item!.completedQuestionCount}/${item!.progressInfo.totalQuestionCount}',
                          );

                        case ChatRoomProgress.completed:
                          return ResponseIndicator(
                            followupStatus: FollowupStatus.no, // TODO : 꼬리질문 기능 도입시 해당 부분 수정 필요
                            chatResult: item!.passOrFail,
                            text: item!.passOrFail.isPassed
                                ? context
                                    .tr(LocaleKeys.common_responseResult_pass)
                                : context.tr(
                                    LocaleKeys.common_responseResult_fail,
                                  ),
                          );
                        default:
                          throw UnimplementedError('잘못된 enum값 입니다');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16) +
            const EdgeInsets.only(top: 24, bottom: 24),
        child: SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // CHARACTER IMAGE
              ClipOvalCircleAvatar.createSkeleton(
                size: 64,
              ),
              const Gap(16),
              SizedBox(
                width: AppSize.ratioWidth(174),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CHARACTER NAME
                    SkeletonBox(
                      height: 18,
                      width: 106,
                      padding: EdgeInsets.symmetric(vertical: 2),
                    ),
                    Gap(9),

                    /// LAST CHAT MESSAGE or TOPIC CHIP LIST
                    SkeletonBox(
                      height: 13,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 2),
                    ),
                    SkeletonBox(
                      height: 13,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 2),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // LAST CHAT DATE
                  SkeletonBox(
                    height: 13,
                    width: 50,
                    padding: EdgeInsets.symmetric(vertical: 4),
                  ),

                  // PROGRESS INDICATOR
                  SkeletonBox(
                    height: 26,
                    width: 47,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
