import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/app/util/app_logger.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/feedback_response_entity.dart';
import 'package:techtalk/features/chat/use_cases/set_ai_follow_up_question_use_case.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/chat_qnas_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/is_follow_up_process_active_provider.dart';
import 'package:techtalk/presentation/pages/interview/chat/providers/selected_chat_room_provider.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';
import 'package:uuid/uuid.dart';

part 'chat_message_history_internal_event.p.dart';
part 'chat_message_history_provider.g.dart';
part 'common_type_chat_message_history_internal_event.p.dart';
part 'proficiency_type_chat_message_history_internal_event.p.dart';
part 'resume_type_chat_message_history_internal_event.p.dart';
part 'youtube_type_chat_message_history_internal_event.p.dart';

@riverpod
class ChatMessageHistory extends _$ChatMessageHistory {
  // ignore: avoid_public_notifier_properties
  /// 꼬리질문 프로세스 실행 여부값을 반환하는 completor
  /// 다른 provider에서 해당 값을 접근하여 필요한 예외처리 로직을 실행함
  Completer<bool> isFollowUpProcessActive = Completer<bool>();

  @override
  FutureOr<List<BaseChatEntity>> build() async {
    final room = ref.read(selectedChatRoomProvider);

    // 단골 질문 (주제별, 실전형)
    final getChatList = switch (room.progressState) {
      ChatRoomProgress.initial => () async {
          await room.type.typedBranch(
            common: (_) async {
              await _showIntroAndCommonQuestionMessages();
            },
            resume: (_) async {
              await _showResumeTypeIntroMessages();
            },
            youtube: (_) async {
              await _showYoutubeTypeIntroMessages();
            },
            proficiency: (_) {
              return _showProficiencyTypeIntroMessages();
            },
          );

          return <BaseChatEntity>[];
        },
      ChatRoomProgress.ongoing || ChatRoomProgress.completed => () async {
          final response = await getChatMessageHistoryUseCase(room.id);
          return response.fold(
            onSuccess: (chatCollection) {
              ref
                  .read(chatQnasProvider.notifier)
                  .arrangeQnasInOrder(chatCollection.progressQnaIds);
              return chatCollection.chatHistories;
            },
            onFailure: (e) {
              logger.e(e.toString());

              throw e;
            },
          );
        },
    };
    return getChatList();
  }

  ///
  /// 유저의 채팅 답변 이후 인터뷰 진행 프로세스 단계를 실행시킴
  /// 인터뷰 진행 프로세스는 크게 4가지 프로세스로 구성됨.
  /// 1) 유저의 답변 채팅 메세지 추가
  /// 2) 유저의 답변 정답 여부 확인
  /// 3) 유저 답변에 대한 피드백 채팅 전달
  /// 4) 피드백 채팅이 전달된 이후 가이드 채팅과 다음 질문 채팅을 전달
  ///
  Future<void> proceedInterviewStep(String message) async {
    await _addUserMessage(message).then(handleFeedbackProgress);
  }

  ///
  /// 1) 유저의 답변 채팅 메세지 추가
  ///
  Future<AnswerChatEntity> _addUserMessage(String message) async {
    final answeredQuestion = state.requireValue
        .firstWhere((chat) => chat is QuestionChatEntity) as QuestionChatEntity;

    final answerChat = AnswerChatEntity.initial(
      message: message,
      qnaId: answeredQuestion.qnaId,
      rootQnaId: answeredQuestion.rootQnaId!,
    );

    await showMessage(
      message: answerChat,
    );

    return answerChat;
  }

  ///
  /// 유저의 면접 질문 대답에 응답.
  /// 아래와 같은 이벤트를 실행시킴
  /// 2) 유저의 답변 정답 여부 확인
  /// 3) 유저 답변에 대한 피드백 채팅 전달
  /// 4) 피드백 채팅이 전달된 이후 가이드 채팅과 다음 질문 채팅을 전달
  ///
  Future<void> handleFeedbackProgress(AnswerChatEntity userAnswer) async {
    AnswerChatEntity? resolvedUserAnswer;
    late bool isAnswerCorrect;

    final room = ref.read(selectedChatRoomProvider);

    final chatHistory = [
      ...state.requireValue
          .where((element) => element.rootQnaId == userAnswer.rootQnaId)
    ].reversed.toList();

    final rootQna = ref
        .read(chatQnasProvider.notifier)
        .getCommonQnaById(userAnswer.rootQnaId ?? userAnswer.qnaId);

    isFollowUpProcessActive = Completer<bool>();

    final response = getAnswerFeedBackUseCase.call(
      (
        chatHistory: chatHistory,
        qna: rootQna,
        interviewType: room.type,
        userName: ref.read(userInfoProvider).requireValue!.nickname!,
        onError: _onAiFeedbackErrorOccured,
        youtubeExtra: room.youtubeExtra,
        checkAnswer: ({required AnswerState answerState}) async {
          /// 만약 정상 작동하지 못했다면
          /// 기존 응답 메세지를 제거하고
          /// 팝업을 노출
          if (answerState == AnswerState.error) {
            _onAiFeedbackErrorOccured();
          } else {
            /// 2) 유저의 답변 정답 여부 확인
            resolvedUserAnswer = await _updateUserAnswerState(
              answerState: answerState,
              targetChatHistory: chatHistory,
            );

            if (resolvedUserAnswer == null) {
              _onAiFeedbackErrorOccured();
              return;
            }

            final uploadTargetChat =
                chatHistory.whereType<QuestionChatEntity>().toList().last;

            if (uploadTargetChat.isFollowUpQuestion) {
              resolvedUserAnswer = resolvedUserAnswer!.copyWith(
                followUpQuestion: uploadTargetChat.message.value,
              );
            }

            isAnswerCorrect = answerState.isCorrect;
          }
        },
        onFeedBackCompleted: (
            {required FeedbackResponseEntity feedbackResponse}) async {
          if (kDebugMode) {
            log(
              '\n👀feedback: ${feedbackResponse.feedback}\n👀score: ${feedbackResponse.score}\n👀isFollowUpQuestionNeeded: ${feedbackResponse.isFollowUpQuestionNeeded}\n',
            );
          }
          if (resolvedUserAnswer == null) {
            _onAiFeedbackErrorOccured();
            return;
          }

          unawaited(
            FirebaseAnalytics.instance.logEvent(
              name: 'Question Answered',
              parameters: {
                'qna_id': resolvedUserAnswer!.qnaId,
                'is_correct': isAnswerCorrect.toString(),
              },
            ),
          );

          late QuestionChatEntity nextQuestionChat;
          late GuideChatEntity guideChat;
          late String guideMessage;
          late ChatQnaEntity newQna;
          late FeedbackChatEntity feedbackChat;

          feedbackChat = FeedbackChatEntity.createStatic(
            message: feedbackResponse.feedback,
            timestamp: DateTime.now(),
            rootQnaId: rootQna.qna.id,
            qnaId: userAnswer.qnaId,
          );

          /// 꼬리질문 프로세스 실행여부. 아래와 같은 조건을 모든 만족해야됨
          ///
          /// 1. AI가 적절한 꼬리 질문을 생성할 수 있는 상태
          /// 2. 유저의 답변 점수가 1을 초과할 경우
          /// 3. 유저가 꼬리 질문을 비활성화 하지 않았을 경우
          final isFollowUpProcessActivate =
              feedbackResponse.isFollowUpQuestionNeeded &&
                  chatHistory.whereType<QuestionChatEntity>().length < 2 &&
                  feedbackResponse.score > 1 &&
                  ref.read(isFollowUpProcessActiveProvider).isTrue;

          isFollowUpProcessActive.complete(isFollowUpProcessActivate);

          if (isFollowUpProcessActivate) {
            /// 꼬리질문일 경우
            /// root 질문에 대항 피드백 chat도 포함시켜
            /// 적절한 꼬리 질문을 생성할 수 있도록함
            chatHistory.add(feedbackChat);
            await _startFollowUpQuestion(
              rootFeedbackResponse: feedbackResponse,
              chatHistory: chatHistory,
              rootAnswerChat: resolvedUserAnswer!,
            );

            /// !!! 꼬리 질문이 있을 경우 '리턴' 하여 프로세스 중단 !!!
            return;
          }

          /// 4) 피드백 채팅이 전달된 이후 가이드 채팅과 다음 질문 채팅을 전달
          final isCompleted =
              ref.read(chatQnasProvider.notifier).isEveryQnaCompleted();

          /// 다음 면접 질문을 제시
          if (!isCompleted) {
            newQna = _getNewQna()!;
            guideMessage = rootNavigatorKey.currentContext!.tr(
              LocaleKeys.undefined_next_question_prompt,
              namedArgs: {
                'topic': room.type.isPractical
                    ? StoredTopics.getById(newQna.qna.id.getFirstPartOfSpliited)
                        .text
                    : '',
              },
            );
          } else {
            guideMessage = rootNavigatorKey.currentContext!
                .tr(LocaleKeys.undefined_interview_ended);
          }

          /// NOTE : 순서 주의
          guideChat = GuideChatEntity.createStatic(
            message: guideMessage,
            timestamp: DateTime.now(),
          );

          if (!isCompleted) {
            nextQuestionChat = QuestionChatEntity.createStatic(
              qnaId: newQna.qna.id,
              rootQnaId: newQna.qna.id,
              message: newQna.qna.question,
              timestamp: DateTime.now(),
            );
          }

          await Future.wait(
            [
              _uploadMessage([
                if (!isCompleted) nextQuestionChat,
                guideChat,
                feedbackChat,
                resolvedUserAnswer!,
              ]).then(
                (_) => ref
                    .read(selectedChatRoomProvider.notifier)
                    .updateProgressInfo(
                      isCorrect: isAnswerCorrect,
                      lastChatMessage:
                          isCompleted ? guideChat : nextQuestionChat,
                    ),
              ),
              showMessage(
                message: guideChat.overwriteToStream(),
                onDone: () async {
                  if (!isCompleted) {
                    await showMessage(
                      message: nextQuestionChat.overwriteToStream(),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );

    await showMessage(
      message: FeedbackChatEntity(
        message: response,
        qnaId: rootQna.qna.id,
        rootQnaId: rootQna.qna.id,
      ),
    );
  }

  ///
  /// 가장 마지막으로 보낸진 [ReceivedChatEntity] 데이터 여부
  /// 하나의 질문 단위로 섹션이 구분
  ///
  /// ex)
  /// [ReceivedChatEntity](N) - [ReceivedChatEntity](Y) - [AnswerChatEntity]
  /// [ReceivedChatEntity](N) - [ReceivedChatEntity](Y) - [AnswerChatEntity] - [ReceivedChatEntity](N) - [ReceivedChatEntity](Y)
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
}
