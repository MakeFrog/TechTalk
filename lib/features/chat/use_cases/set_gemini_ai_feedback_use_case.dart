import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/app/environment/flavor.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';

/// gemini-1.5-pro-001 모델에서는 한정된 SafetySetting만 가능
final safetySettings = [
  SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
  SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
];

final gemini = GenerativeModel(
  model: 'gemini-1.5-pro-001',
  apiKey: Flavor.env.geminiApiKey,
  systemInstruction: Content.system(
    'You are the interviewer, and the user is the candidate.',
  ),
  safetySettings: safetySettings,
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
      You will ask an interview question and verify the correctness of the user's answer.

      The candidate's name is ${param.userName}. Always refer to the user by this nickname.
      The question is related to ${StoredTopics.getById(param.qna.qna.id.getFirstPartOfSpliited)}.
      The question presented is: ${param.question}.
      The model answer is: ${param.qna.qna.answers.map((str) => '-$str').join(' ')}'
      ${param.userName} answered: "${param.userAnswer}".

      Based on the model answer provided, determine whether ${param.userName}'s response is correct by prefixing your response with "[c]" if it is correct, or "[w]" if it is incorrect. Provide a brief explanation of up to 100 characters regarding the correctness and quality of the answer.

      If ${param.userAnswer} contains inappropriate or offensive content, respond with "[i]" indicating that the answer is unacceptable. Provide a brief explanation of why the answer is not suitable and how it should be appropriately addressed.
      
      Please respond in the language corresponding to language code "${AppLocale.currentLocale.languageCode}".
    
'''),
        ],
        generationConfig: GenerationConfig(
          temperature: 0.4,
          maxOutputTokens: 300,
        ),
      ).listen(
        (it) {
          /// 연속적인 응답 값을 반환 할때
          /// 1) 정답 여부 확인
          /// 2) 응답 텍스트 포맷
          /// 3) 스트림 값 삽입
          ///
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
    void Function({required AnswerState answerState}) checkAnswer,
  ) {
    if (!state.isOnProgress) return;

    late final AnswerState answerState;

    // 모든 AnswerState 값을 순회하면서 적절한 상태를 찾음
    answerState = AnswerState.values.firstWhere(
      (state) => response.contains(state.tag),
      orElse: () => AnswerState.wrong,
    );

    HapticFeedback.lightImpact();

    checkAnswer.call(answerState: answerState);
  }

  /// 응답값 포맷
  /// 1. [c] & [w] 인디에키터 포맷, [AnswerState]
  /// 2. 불필요 줄바꿈 제거
  String formatResponse(String response) {
    String formattedText = response.replaceAll('\n', '').trim();

    if (formattedText.length <= 3) return '';

    for (final state in AnswerState.values) {
      if (formattedText.contains(state.tag)) {
        return formattedText.replaceFirst(state.tag, '').trim();
      }
    }

    return formattedText;
  }
}

/// [SetGeminiAiFeedbackUseCase] 파라미터
typedef GetQuestionFeedbackParam = ({
  ChatQnaEntity qna,
  String question,
  String userAnswer,
  String userName,
  void Function(String feedback) onFeedBackCompleted,
  void Function({required AnswerState answerState}) checkAnswer
});
