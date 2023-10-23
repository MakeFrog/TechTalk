import 'dart:async';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/core/helper/string_extension.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/core/utils/route_argument.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/presentation/widgets/common/toast/app_toast.dart';

part 'chat_list_provider.g.dart';

@riverpod
class ChatList extends _$ChatList {
  @override
  FutureOr<List<ChatEntity>> build() async {
    final response = await getChatListUseCase(RouteArg.argument);
    return response.fold(
      onSuccess: (chatList) {
        return chatList;
      },
      onFailure: (e) {
        /// 실패 아래와 같은 동작을 실행할 수 있음
        /// 1. 파이어베이스 버그 리포트 - SET FIREBASE ANALYTICS LOG
        /// 2. 구조화된 로그 (Presentation, 로깅)
        /// 3. 트스트 Alert 메세지
        log(e.toString());
        ToastService().show(toast: NormalToast(message: '채팅 내역을 불러오지 못하였습니다'));
        throw e;
      },
    );
  }

  ///
  /// 유저 채팅 응답 추가
  ///
  Future<void> addUserChatResponse({required String message}) async {
    await update(
      (previous) => [
        SentChatEntity.create(message: message),
        ...previous,
      ],
    );
  }

  ///
  /// 가장 마지막으로 보낸진 [ReceivedChatEntity] 데이터 여부
  /// 하나의 질문 단위로 섹션이 구분
  ///
  /// ex)
  /// [ReceivedChatEntity](N) - [ReceivedChatEntity](Y) - [SentChatEntity]
  /// [ReceivedChatEntity](N) - [ReceivedChatEntity](Y) - [SentChatEntity] - [ReceivedChatEntity](N) - [ReceivedChatEntity](Y)
  ///
  bool isLastReceivedChatInEachQuestion({required int index}) {
    final chatList = state.requireValue;

    if (index != 0 && state.requireValue[index - 1].type.isSentMessage) {
      return true;
    }

    if (index == 0 && chatList.first.type.isReceivedMessage) {
      return true;
    }

    return false;
  }

  ///
  /// 유저의 면접 질문 대답에 응답
  /// 정답 여부를 판별하고
  /// 간단한 설명을 덧붙여 피드백을 함.
  ///
  Future<void> respondToUserAnswer({required String userAnswer}) async {
    await update(
      (previous) => [
        ReceivedChatEntity.createStreamChat(
          type: ChatType.replyToUserAnswer,
          message: getGptReplyOnUserResponse.call(
            (
              category: 'Swift',
              checkAnswer: updateUserAnswerState,
              onFeedBackCompleted: showNextQuestion,
              question: state.requireValue
                  .firstWhere((chat) => chat.type.isAskQuestionMessage)
                  .message
                  .value,
              userAnswer: userAnswer,
            ),
          ),
        ),
        ...previous
      ],
    );
  }

  ///
  /// 다음 면접 질문 제시
  ///
  Future<void> showNextQuestion() async {
    await update(
      (previous) => [
        ReceivedChatEntity.createStreamChat(
          message: 'Swift의 upcasting과 downcasting의 차이에 대해서 설명해보세요.'
              .convertToStreamText,
          type: ChatType.askQuestion,
        ),
        ...previous,
      ],
    );
  }

  ///
  /// 유저 답변 정답 여부 상태 변경
  ///
  void updateUserAnswerState({required bool isCorrect}) {
    final chatList = state.requireValue;

    final item = chatList.firstWhere((element) => element.type.isSentMessage)
        as SentChatEntity;

    if (isCorrect) {
      chatList[1] = item.copyWith(answerState: AnswerState.correct);
    } else {
      chatList[1] = item.copyWith(answerState: AnswerState.wrong);
    }

    update((previous) => chatList);
  }
}
