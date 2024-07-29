import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/app/environment/flavor.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';

final gemini = GenerativeModel(
  model: 'gemini-1.5-pro-001',
  apiKey: Flavor.env.geminiApiKey,
);

class SetGeminiAiFeedbackUseCase
    extends BaseNoFutureUseCase<GetQuestionFeedbackParam, Result<BehaviorSubject<String>>> {
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
    final BehaviorSubject<String> streamedFeedbackResponse = BehaviorSubject<String>();
    state = FeedbackProgress.onProgress;

    String response = '';

    try {
      gemini.generateContentStream(
        [
          Content.text('''
    면접 질문을 물어보고 유저 답변의 정답 여부를 확인합니다. 당신은 면접관, 유저는 지원자입니다.
    지원자의 이름은 ${param.userName}입니다. 유저를 지칭할 때에는 항상 닉네임으로 불러주세요.
    ${StoredTopics.getById(param.qna.qna.id.getFirstPartOfSpliited)}와 관련된 질문입니다.
    제시된 질문은 ${param.question} 입니다.
    모범답안은 다음과 같습니다. ${param.qna.qna.answers.map((str) => '-$str').join(' ')}'
    ${param.userName}님은 질문에 "${param.userAnswer}"라고 답변하였습니다.
    제시된 모범답안을 참고해서 정답 여부를 판별하고 ${param.userName}님이 적합하게 답변했으면
    "[c]"를, 반대로 오답이라면 "[w]"라는 태그 단어를 문장 맨 앞에 붙여서 정답 여부를 표시해주고
    그 이유를 100글자 이내로 간략하게 설명해주세요. 정답이긴 하지만 유저가 제시한 답변이 조금 부족하다면
    유저가 추가적으로 어떤 답안을 추가하면 좋을지도 포함하여 100글자 이내로 간략하게 설명해주세요.
    이모티콘 붙이지 마세요.
    
'''),
        ],
        generationConfig: GenerationConfig(
          temperature: 0.3,
          maxOutputTokens: 300,
        ),
      ).listen(
        (it) {
          /// 연속적인 응답 값을 반환 할때
          /// 1) 정답 여부 확인
          /// 2) 응답 텍스트 포맷
          /// 3) 스트림 값 삽입
          ///
          if ((it.text ?? '').isEmpty) return;

          response += it.text ?? '';
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
      ).onDone(() {
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
      });

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

/// [SetGeminiAiFeedbackUseCase] 파라미터
typedef GetQuestionFeedbackParam = ({
  ChatQnaEntity qna,
  String question,
  String userAnswer,
  String userName,
  void Function(String feedback) onFeedBackCompleted,
  void Function({required bool isCorrect}) checkAnswer
});
