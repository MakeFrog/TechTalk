import 'package:flutter/material.dart';
import 'package:techtalk/core/constants/interview_type.enum.dart';
import 'package:techtalk/core/helper/date_time_extension.dart';
import 'package:techtalk/core/services/size_service.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/core/theme/extension/app_text_style.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/chat_list_event.dart';
import 'package:techtalk/presentation/widgets/common/avatar/clip_oval_circle_avatar.dart';
import 'package:techtalk/presentation/widgets/common/box/skeleton_box.dart';
import 'package:techtalk/presentation/widgets/common/indicator/pass_fail_indicator.dart';

class ChatListItemView extends StatelessWidget with ChatListEvent {
  const ChatListItemView({
    Key? key,
    required this.item,
    required this.isLoaded,
  }) : super(key: key);

  factory ChatListItemView.create(InterviewType type, ChatRoomEntity item) =>
      ChatListItemView(item: item, isLoaded: true);

  factory ChatListItemView.createSkeleton() =>
      const ChatListItemView(item: null, isLoaded: false);

  final ChatRoomEntity? item;
  final bool isLoaded;

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      return MaterialButton(
        height: 112,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        onPressed: () {
          routeToChatPage(
            context,
            room: item!,
          );
        },
        child: SizedBox(
          height: 64,
          child: Row(
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
                height: 64,
                width: AppSize.to.rationWidth(174),
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CHARACTER NAME
                    Text(
                      item!.interviewer.name,
                      style: AppTextStyle.title1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),

                    /// LAST CHAT MESSAGE
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        height: (AppTextStyle.alert2.height! *
                                AppTextStyle.alert2.fontSize!) *
                            2,
                        width: AppSize.to.rationWidth(174),
                        child: Text(
                          item!.lastChatMessage ?? '',
                          style: AppTextStyle.alert2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // LAST CHAT DATE
                  Text(
                    item!.lastChatDate?.formatyyMMdd ?? '',
                    style: AppTextStyle.alert2.copyWith(
                      color: AppColor.of.gray3,
                    ),
                  ),
                  // PROGRESS INDICATOR
                  Builder(
                    builder: (context) {
                      switch (item!.progressState) {
                        case ChatRoomProgress.initial ||
                              ChatRoomProgress.ongoing:
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.of.background1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${item!.completedQuestionCount}/${item!.progressInfo.totalQuestionCount}',
                              style: AppTextStyle.alert1
                                  .copyWith(color: AppColor.of.gray6),
                            ),
                          );
                        case ChatRoomProgress.completed:
                          return PassFailIndicator(
                            status: item!.passOrFail,
                            text: item!.passOrFail.isPassed ? '합격' : '불합격',
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
      return Container(
        height: 112,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: SizedBox(
          height: 64,
          child: Row(
            children: <Widget>[
              // CHARACTER IMAGE
              ClipOvalCircleAvatar.createSkeleton(
                size: 64,
              ),
              const SizedBox(
                width: 16,
              ),

              SizedBox(
                height: 64,
                width: AppSize.to.rationWidth(174),
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CHARACTER NAME
                    const SkeletonBox(
                      height: 18,
                      width: 106,
                      padding: EdgeInsets.symmetric(vertical: 2),
                    ),

                    /// LAST CHAT MESSAGE
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        height: (AppTextStyle.alert2.height! *
                                AppTextStyle.alert2.fontSize!) *
                            2,
                        width: AppSize.to.rationWidth(174),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
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
                    ),
                  ],
                ),
              ),

              const Spacer(),
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // LAST CHAT DATE
                  SkeletonBox(
                    height: 13,
                    width: 50,
                    padding: EdgeInsets.symmetric(vertical: 4),
                  ),
                  SkeletonBox(
                    height: 26,
                    width: 47,
                  ),
                  // PROGRESS INDICATOR
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
