import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'chat_list_provider.g.dart';

@riverpod
class ChatList extends _$ChatList {
  @override
  FutureOr<List<ChatRoomListItemEntity>> build() async {
    final response = await getChatListUseCase(InterviewTopic.swift);
    return response.fold(
      onSuccess: (chatList) {
        return chatList;
      },
      onFailure: (e) {
        log(e.toString());
        throw e;
      },
    );
  }
}
