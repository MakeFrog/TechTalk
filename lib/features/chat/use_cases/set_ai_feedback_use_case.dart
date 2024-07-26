import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';

class SetAiFeedbackUseCase extends BaseNoFutureUseCase<GetQuestionFeedbackParam,
    Result<BehaviorSubject<String>>> {
  ///
  /// 피드백 진행 상태
  ///
  FeedbackProgress state = FeedbackProgress.init;

  ///
  /// 면접 질문에 대한 유저의 응답의 정답여부를 확인
  /// propmt 로직을 고도화 할 필요 있음.
  ///
  @override
  Result<BehaviorSubject<String>> call(GetQuestionFeedbackParam param) {
    final BehaviorSubject<String> streamedFeedbackResponse =
        BehaviorSubject<String>();
    state = FeedbackProgress.onProgress;

    String response = '';

    try {
      OpenAI.instance
          .onChatCompletionSSE(
        request: ChatCompleteText(
          messages: [
            Messages(
              role: Role.system,
              content: tr(LocaleKeys.undefined_interview_prompt),
            ),
            Messages(
              role: Role.system,
              content: tr(
                LocaleKeys.undefined_user_name_prompt,
                namedArgs: {'nickname': param.userName},
              ),
            ),
            Messages(
              role: Role.system,
              content: tr(
                LocaleKeys.undefined_model_answer_prompt,
                namedArgs: {
                  'relatedAnswer':
                      '${StoredTopics.getById(param.qna.qna.id.getFirstPartOfSpliited)}',
                  'question': param.question,
                  'modelAnswer':
                      param.qna.qna.answers.map((str) => '-$str').join(' '),
                },
              ),
            ),
            Messages(
              role: Role.user,
              content: param.userAnswer,
            ),
            Messages(
              role: Role.system,
              content: tr(
                LocaleKeys.undefined_user_answer_prompt,
                namedArgs: {
                  'nickname': param.userName,
                  'answer': param.userAnswer,
                },
              ),
            ),
          ],
          maxToken: 300,
          model: Gpt4ChatModel(),
          temperature: 0.5,
          stream: true,
          user: FirebaseAuth.instance.currentUser!.uid,
        ),
      )
          .listen(
        (it) {
          /// 연속적인 응답 값을 반환 할때
          /// 1) 정답 여부 확인
          /// 2) 응답 텍스트 포맷
          /// 3) 스트림 값 삽입

          response += it.choices?.last.message?.content ?? '';
          setCorrectnessIfNeeded(response, param.checkAnswer);
          streamedFeedbackResponse.add(formatResponse(response));
        },
        onDone: () {
          /// 응답이 종료된 이후
          /// 1) Stream 닫기
          /// 2) 응답 진행 상태 초기화
          /// 3) 완료 콜백 메소드 실행
          state = FeedbackProgress.init;
          streamedFeedbackResponse.close().then(
                (_) => param.onFeedBackCompleted(
                  formatResponse(streamedFeedbackResponse.value),
                ),
              );
        },
      );
      return Result.success(streamedFeedbackResponse);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  ///
  /// 정답 여부를 확인하는 메소드
  ///
  void setCorrectnessIfNeeded(
    String response,
    void Function({required bool isCorrect}) checkAnswer,
  ) {
    if (!state.isOnProgress) return;

    if (response.contains(AnswerState.wrong.tag)) {
      checkAnswer(
        isCorrect: false,
      );
      state = FeedbackProgress.completed;
    } else if (response.contains(AnswerState.correct.tag)) {
      state = FeedbackProgress.completed;
      checkAnswer(
        isCorrect: true,
      );
    }
    HapticFeedback.lightImpact();
  }

  /// 응답값 포맷
  /// 1. [c] & [w] 인디에키터 포맷, [AnswerState]
  /// 2. 불필요 줄바꿈 제거
  String formatResponse(String response) {
    String formattedText = response.replaceAll('\n', '');

    if (formattedText.length <= 3) return '';

    if (formattedText.contains(AnswerState.wrong.tag)) {
      return formattedText.replaceFirst(AnswerState.wrong.tag, '').trim();
    } else {
      return formattedText.replaceFirst(AnswerState.correct.tag, '').trim();
    }
  }
}

/// [SetAiFeedbackUseCase] 파라미터
typedef GetQuestionFeedbackParam = ({
  ChatQnaEntity qna,
  String question,
  String userAnswer,
  String userName,
  void Function(String feedback) onFeedBackCompleted,
  void Function({required bool isCorrect}) checkAnswer
});
