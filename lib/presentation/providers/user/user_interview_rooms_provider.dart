import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';
import 'package:techtalk/presentation/providers/user/user_data_provider.dart';

part 'user_interview_rooms_provider.g.dart';

@Riverpod(keepAlive: true)
class UserInterviewRooms extends _$UserInterviewRooms {
  @override
  FutureOr<List<ChatRoomEntity>> build(TopicEntity topic) async {
    final hasUserData = await ref.watch(userDataProvider.future) != null;

    if (!hasUserData) {
      throw Exception('유저 데이터가 존재하지 않음');
    }

    final response = await getChatListUseCase(topic.id);

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
