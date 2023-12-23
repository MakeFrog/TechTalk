import 'dart:developer';

import 'package:chatgpt_completions/chatgpt_completions.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/core/utils/base/base_no_future_use_case.dart';
import 'package:techtalk/features/chat/chat.dart';

class GetAnswerFeedbackUseCase extends BaseNoFutureUseCase<
    GetQuestionFeedbackParam, BehaviorSubject<String>> {
  // ##########  State  ##############

  ///
  /// 피드백 진행 상태
  ///
  FeedbackProgress state = FeedbackProgress.init;

  // ##########  Intent  ##############

  ///
  /// 면접 질문에 대한 유저의 응답의 정답여부를 확인
  /// propmt 로직을 고도화 할 필요 있음.
  ///
  @override
  BehaviorSubject<String> call(GetQuestionFeedbackParam param) {
    final BehaviorSubject<String> streamedFeedbackResponse =
        BehaviorSubject<String>();
    state = FeedbackProgress.onProgress;

    log('Subject : ${param.category}\n Question : ${param.question}\n UserAnswer : ${param.userAnswer}');

    ChatGPTCompletions.instance.textCompletions(
      /// GPT Completion 조건
      TextCompletionsParams(
        prompt: '프로그래밍 면접 질문을 물어보고 답변의 정답 여부를 확인합니다. 컴퓨터는 면접과 유저는 지원자 입니다',
        model: GPTModel.gpt3p5turbo,
        messagesTurbo: [
          MessageTurbo(
            role: TurboRole.system,
            content: '면접관과 실제와 대화하는 것 처럼 자연스럽게 대해주세요',
          ),
          MessageTurbo(
              role: TurboRole.assistant,
              content:
                  '${param.category}분야의 질문입니다. ${param.checkAnswer}. 질문 의도에 맞는 답변을 해주세요'),
          MessageTurbo(
            role: TurboRole.system,
            content:
                '모범 답변을 참고해서 정답 여부를 판별해주세요. 모법답안 : 서로 상속 관계에 있는 클래스에서 자식 클래스를 부모 클래스로 타입캐스팅 하는 것을 업 캐스팅이라고 하고 as를 사용해서 업 캐스팅할 수 있습니다',
          ),
          MessageTurbo(
            role: TurboRole.user,
            content: param.userAnswer,
          ),
          MessageTurbo(
            role: TurboRole.system,
            content:
                '제시된 모범답변을 참고해서 정답 여부를 판별해주고 이때 실제 지원자에게 말하는듯이 자연스럽게 대해주세요. ${param.question}라는 면접관의 질문에 지원자는 정답이 "${param.userAnswer}" 라고 답변하였습니다. 이때 지원자가 적합하게 답변했으면 "[c]"를, 반대로 오답이라면 "[w]"라는 태그 단어를 문장 맨 앞에 붙여서 정답 여부를 표시해주고 이유도 100글자 이내로 간략하게 설명해주세요',
          ),
        ],
        temperature: 0.5,
        topP: 1,
        n: 1,
        stream: true,
        maxTokens: 300,
      ),

      /// 연속적인 응답 값을 반환 할때
      /// 1) 정답 여부 확인
      /// 2) 응답 텍스트 포맷
      /// 3) 스트림 값 삽입
      onStreamValue: (response) {
        setCorrectnessIfNeeded(response, param.checkAnswer);
        final filteredRes = formatResponse(response);
        streamedFeedbackResponse.add(filteredRes);
      },
    ).then(
      /// 응답이 종료된 이후
      /// 1) Stream 닫기
      /// 2) 응답 진행 상태 초기화
      /// 3) 완료 콜백 메소드 실행
      (_) {
        streamedFeedbackResponse.close();
        state = FeedbackProgress.init;
        param.onFeedBackCompleted();
      },
    );

    return streamedFeedbackResponse;
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
      checkAnswer(isCorrect: false);
      state = FeedbackProgress.completed;
    } else if (response.contains(AnswerState.correct.tag)) {
      state = FeedbackProgress.completed;
      checkAnswer(isCorrect: true);
    }
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

/// [GetAnswerFeedbackUseCase] 파라미터
typedef GetQuestionFeedbackParam = ({
  String category,
  String question,
  String userAnswer,
  VoidCallback onFeedBackCompleted,
  void Function({required bool isCorrect}) checkAnswer
});
