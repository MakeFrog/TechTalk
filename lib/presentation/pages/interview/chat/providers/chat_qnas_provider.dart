import 'dart:developer' as dev;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/services/snack_bar_servbice.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';

part 'chat_qnas_provider.g.dart';

///
/// 채팅 Qna 리스트
///
@Riverpod(dependencies: [SelectedChatRoom])
class ChatQnas extends _$ChatQnas {
  @override
  FutureOr<List<ChatQnaEntity>> build() async {
    final room = ref.read(selectedChatRoomProvider);

    if (room.progressState.isInitial) {
      final response = await getRandomQnaUseCase.call(room);
      return response.fold(
        onSuccess: (randomQnas) => randomQnas,
        onFailure: (e) => _onError(e),
      );
    } else {
      final response = await getChatQnasUseCase.call(room);
      return response.fold(
        onSuccess: (qnas) => qnas,
        onFailure: (e) => _onError(e),
      );
    }
  }

  ///
  /// qna 상태 업데이트
  ///
  Future<void> updateState(AnswerChatMessageEntity message) async {
    final qnas = state.requireValue;
    final targetQnaIndex = qnas.indexWhere((e) => e.id == message.qnaId);
    final resolvedQna = qnas[targetQnaIndex].copyWith(
      answer: message,
    );

    await update((previous) {
      return [...previous]..[targetQnaIndex] = resolvedQna;
    });
  }

  ///
  /// 전체 qna 리스트 진행 완료 여부
  ///
  bool isEveryQnaCompleted() {
    return state.requireValue.every((e) => e.hasUserResponded);
  }

  _onError(Exception e) {
    dev.log('$e');
    SnackBarService.showSnackBar('문답 목록을 가져오는데 실패하였습니다');
    throw e;
  }
}
