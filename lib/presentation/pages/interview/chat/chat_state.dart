import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/features/chat/entities/enums/interview_progress.enum.dart';
import 'package:techtalk/features/chat/entities/interviewer_entity.dart';
import 'package:techtalk/features/chat/entities/message/chat_message_entity.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_async_adapter_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_message_history_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/interview_progress_state_provider.dart';
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

  ///
  /// chat page에서 사용되는 future provider들의 async 상태
  ///
  AsyncValue chatAsyncAdapterValue(WidgetRef ref) =>
      ref.watch(chatAsyncAdapterProvider);

  ///
  /// 채팅 메세지 기록
  ///
  List<ChatMessageEntity> chatMessageHistory(WidgetRef ref) =>
      ref.watch(chatMessageHistoryProvider).requireValue;

  ///
  /// 인터뷰 진행 상태
  ///
  InterviewProgress progressState(WidgetRef ref) =>
      ref.watch(interviewProgressStateProvider);
}
