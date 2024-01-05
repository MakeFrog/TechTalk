import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/constants/interview_type.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/topic.dart';

part 'interview_rooms_provider.g.dart';

@Riverpod()
class InterviewRooms extends _$InterviewRooms {
  @override
  FutureOr<List<ChatRoomEntity>> build(
    InterviewType type, [
    String? topicId,
  ]) async {
    final topic =
        topicId != null ? getTopicUseCase(topicId).getOrThrow() : null;
    final response = await getChatRoomsUseCase(type, topic);

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
