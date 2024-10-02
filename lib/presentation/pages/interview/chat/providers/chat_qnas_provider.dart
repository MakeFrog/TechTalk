import 'dart:async';
import 'dart:developer' as dev;
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/services/snack_bar_service.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/follow_up_qna_entity.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/pages/wrong_answer_note/providers/wrong_answers_provider.dart';

part 'chat_qnas_provider.g.dart';

///
/// 채팅 Qna 리스트
///
@riverpod
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
  Future<void> updateState(AnswerChatEntity message) async {
    final qnas = state.requireValue;
    final targetQnaIndex = qnas.indexWhere((e) => e.qna.id == message.rootQnaId);

    // if (targetQnaIndex < 0) return;



    final isRootQna = message.qnaId == message.rootQnaId;
    print('사무리 : ${message.qnaId} : ${message.rootQnaId}');

    final resolvedQna = isRootQna
        ? qnas[targetQnaIndex].copyWith(
            message: message,
          )
        : qnas[targetQnaIndex].copyWith(
            followUpQna: FollowUpQnaEntity.fromAnswerChatEntity(message));

    print('움튼32 : ${qnas[targetQnaIndex].followUpQna}');
    print('움튼 : ${isRootQna}');
    print('아지랑이랑 : ${resolvedQna.qna.id}');
    if (isRootQna) {
      unawaited(
        Future.wait(
          [
            update((previous) {
              previous.removeAt(targetQnaIndex);
              return [...previous, resolvedQna];
            }),
            _updateWrongAnswer(resolvedQna),
          ],
        ),
      );
    } else {
      print('키리 : ${resolvedQna.followUpQna}');
      try {
        unawaited(
          Future.wait(
            [
              update((previous) {
                final targetArray = previous;
                final targetIndex =
                previous.indexWhere((e) => e.qna.id == resolvedQna.qna.id);
                targetArray[targetIndex] = resolvedQna;
                return [...targetArray];
              }),
              // _updateWrongAnswer(resolvedQna),
            ],
          ),
        );
      } catch(e) {
        print('키리 오류 : ${e}');
      }

    }
  }

  ///
  /// 전체 qna 리스트 진행 완료 여부
  ///
  bool isEveryQnaCompleted() {
    return state.requireValue.every((e) =>
        e.hasUserResponded &&
        (e.followUpQna?.answerState.isCompleted ?? true));
  }

  _onError(Exception e) {
    dev.log('$e');
    SnackBarService.showSnackBar('문답 목록을 가져오는데 실패하였습니다');
    throw e;
  }

  ///
  /// 기존 Qna 응답 순서별로 qna 목록을 정렬
  ///
  void arrangeQnasInOrder(List<String> prevQnaIdsInOrder) {
    state.requireValue.sort((a, b) => prevQnaIdsInOrder
        .indexOf(a.qna.id)
        .compareTo(prevQnaIdsInOrder.indexOf(b.qna.id)));
  }

  ///
  /// 오답노트 기록 업데이트
  ///
  Future<void> _updateWrongAnswer(ChatQnaEntity qna) async {
    if (qna.message!.answerState.isWrong ||
        qna.message!.answerState.isInappropriate) {
      final response = await updateWrongAnswerUSeCase.call(qna);
      response.fold(
        onSuccess: (_) {
          log('오답 노트 업데이트 성공');
          ref.invalidate(wrongAnswersProvider);
        },
        onFailure: (e) {
          log('오답 노트 업데이트 실 패 : $e');
        },
      );
    }
  }

  ///
  /// id값으로 Qna객체 반환
  ///
  ChatQnaEntity getQnaById(String qnaId) {
    return state.requireValue.firstWhere((e) => e.qna.id == qnaId);
  }
}
