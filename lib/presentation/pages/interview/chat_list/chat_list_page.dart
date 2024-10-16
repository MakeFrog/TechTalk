import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/services/app_size.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_type.enum.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/chat_list_event.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/chat_list_state.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/local_widgets/chat_room_item_view.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';
import 'package:techtalk/presentation/widgets/common/indicator/exception_indicator.dart';

class ChatListPage extends BasePage with ChatListState, ChatListEvent {
  ChatListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    return chatRoomsAsync(ref).when(
      data: (chatList) {
        if (chatList.isEmpty) {
          return Center(
            child: ExceptionIndicator(
              subTitle: tr(LocaleKeys.interview_startYourInterviewByClicking),
              title: tr(LocaleKeys.interview_noInterviewRecords),
              padding: EdgeInsets.only(
                bottom: AppSize.ratioHeight(60),
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: chatList.length,
          itemBuilder: (context, index) {
            return ChatRoomItemView.create(
              selectedInterviewType(ref),
              chatList[index],
            );
          },
        );
      },
      error: (e, _) => const Text('채팅 6 불러오지 못하였습니다'),
      loading: () {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return ChatRoomItemView.createSkeleton();
          },
        );
      },
    );
  }

  @override
  Widget? buildFloatingActionButton(WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        return MaterialButton(
          onPressed: () {
            switch (selectedInterviewType(ref)) {
              case InterviewType.singleTopic:
                routeToQuestionCountSelectPage(
                  ref,
                  topic: selectedTopic(ref)!,
                );
              case InterviewType.practical:
                routeToTopicSelectPage(ref);
            }
          },
          height: 56,
          minWidth: 56,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          color: AppColor.of.brand2,
          child: SvgPicture.asset(
            Assets.iconsPlus,
            color: Colors.white,
          ),
        );
      },
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => BackButtonAppBar(
        title: switch (selectedInterviewType(ref)) {
          InterviewType.singleTopic => selectedTopic(ref)?.text ?? ref.read(selectedChatRoomProvider).singleTopic.text,
          InterviewType.practical => tr(LocaleKeys.undefined_realWorldInterview),
        },
      );

  @override
  bool get setBottomSafeArea => false;
}
