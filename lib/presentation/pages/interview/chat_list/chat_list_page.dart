import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/data/remote/chat_remote_data_source.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/local_widgets/chat_list_item_view.dart';
import 'package:techtalk/presentation/pages/interview/chat_list/providers/chat_list_provider.dart';
import 'package:techtalk/presentation/widgets/base/base_page.dart';
import 'package:techtalk/presentation/widgets/common/app_bar/back_button_app_bar.dart';

class ChatListPage extends BasePage {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context, WidgetRef ref) {
    final chatListAsync = ref.watch(chatListProvider);
    return chatListAsync.when(
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
  PreferredSizeWidget? buildAppBar(BuildContext context) => BackButtonAppBar(
        title: 'Swift ',
        onBackBtnTapped: () {
          ChatRemoteDataSource.to.addChatInfo();
        },
      );
}
