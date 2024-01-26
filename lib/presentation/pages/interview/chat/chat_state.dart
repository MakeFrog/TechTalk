import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/entities/interviewer_entity.dart';
import 'package:techtalk/features/chat/entities/message/chat_message_entity.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';

mixin class ChatState {
  ///
  /// 채팅 목록
  ///
  AsyncValue<List<ChatMessageEntity>> messageHistoryAsync(WidgetRef ref) =>
      ref.watch(chatMessageHistoryProvider);

  ///
  /// 면접과 정보
  ///
  InterviewerEntity interviewer(WidgetRef ref) =>
      ref.read(selectedChatRoomProvider).interviewer;
}
