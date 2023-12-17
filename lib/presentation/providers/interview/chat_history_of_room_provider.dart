import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/providers/interview/selected_interview_room_provider.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';

part 'chat_history_of_room_provider.g.dart';

@riverpod
class ChatHistoryOfRoom extends _$ChatHistoryOfRoom {
  @override
  FutureOr<List<MessageEntity>> build() async {
    final room = ref.watch(selectedInterviewRoomProvider)!;
    final response = await getChatMessagesUseCase(room.chatRoomId);

    return response.fold(
      onSuccess: (chatList) async {
        // 처음 채팅방에 진입한 경우
        if (room.progressSate.isInitial) {
          // ref.read(totalQnaListProvider.notifier).initializeQnaList();
          // await addRandomQuestionToQnaList();
          chatList.first.message.listen(
            null,
            onDone: () {
              // showFirstQuestion();
              chatList.first.message.close();
            },
          );
        }
        // 기존 진행중인 채팅방에 진입한 경우
        else {
          // ref.read(totalQnaListProvider.notifier).updateQnaListByChat(chatList);
        }

        // unawaited(addRandomQuestionToQnaList());a

        return chatList;
      },
      onFailure: (e) {
        /// 실패 아래와 같은 동작을 실행할 수 있음
        /// 1. 파이어베이스 버그 리포트 - SET FIREBASE ANALYTICS LOG
        /// 2. 구조화된 로그 (Presentation, 로깅)
        /// 3. 트스트 Alert 메세지
        log(e.toString());
        ToastService.show(NormalToast(message: '채팅 내역을 불러오지 못하였습니다'));
        throw e;
      },
    );
  }
}
