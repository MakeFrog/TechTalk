import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/constants/assets.dart';
import 'package:techtalk/core/theme/extension/app_color.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/chat_list_event.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/local_widgets/chat_list_item_view.dart';
import 'package:techtalk/presentation/providers/interview/interview_rooms_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class ChatListPage extends BasePage with ChatListEvent {
  ChatListPage({
    Key? key,
    required this.topicId,
  })  : _topic = Topic.getTopicById(topicId),
        super(key: key);

  final String topicId;
  final Topic _topic;

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final roomsAsync = ref.watch(interviewRoomsProvider(topicId));

    return roomsAsync.when(
      data: (chatList) {
        return ListView.builder(
          itemCount: chatList.length,
          itemBuilder: (context, index) {
            return ChatListItemView.create(
              chatList[index],
            );
          },
        );
      },
      error: (e, _) => const Text('채팅 리스트를 불러오지 못하였습니다'),
      loading: () {
        return ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ChatListItemView.createSkeleton();
          },
        );
      },
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return MaterialButton(
          onPressed: () {
            routeToQuestionCountSelectPage(
              ref,
              topic: _topic,
            );
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
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      BackButtonAppBar(
        title: _topic.text,
      );
}
