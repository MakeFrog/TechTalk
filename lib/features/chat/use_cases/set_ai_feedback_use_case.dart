import 'dart:async';
import 'dart:convert';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/feedback_response_entity.dart';

class SetAiFeedbackUseCase extends BaseNoFutureUseCase<GetQuestionFeedbackParam,
    BehaviorSubject<String>> {
  AiAnswerProgress state = AiAnswerProgress.init;

  @override
  BehaviorSubject<String> call(GetQuestionFeedbackParam param) {
    final BehaviorSubject<String> streamedAdviceResponse =
        BehaviorSubject<String>();
    state = AiAnswerProgress.onProgress;

    String response = '';
    String jsonResponse = '';
    bool isCollectingJson = false;

    OpenAI.instance
        .onChatCompletionSSE(
      request: ChatCompleteText(
        functionCall: FunctionCall.auto,
        messages: _createChatMessage(param),
        maxToken: 300,
        model: Gpt4ChatModel(),
        temperature: 0.5,
        stream: true,
        user: FirebaseAuth.instance.currentUser!.uid,
      ),
    )
        .transform(
      StreamTransformer.fromHandlers(
        handleError: (error, stackTrace, sink) {
          param.onError(error, stackTrace);
        },
      ),
    ).listen(
      onError: param.onError,
      cancelOnError: true,
      (it) {
        it as ChatResponseSSE;
        final chunk = it.choices?.last.message?.content ?? '';

        if (chunk.isEmpty) return;

        if (_isStartingJsonCollection(chunk, isCollectingJson)) {
          // JSON 수집 시작
          isCollectingJson = true;
          final jsonStartIndex = chunk.indexOf('{');
          jsonResponse = chunk.substring(jsonStartIndex);
          response += chunk.substring(0, jsonStartIndex);
          streamedAdviceResponse.add(response); // JSON 이전의 데이터만 스트림에 추가
        } else if (isCollectingJson) {
          // JSON 수집 중
          jsonResponse += chunk;
        } else {
          // JSON이 아닌 일반 텍스트 부분을 사용자에게 스트림으로 전달
          response += chunk;
        }

        _setCorrectnessIfNeeded(response, param.checkAnswer);
        streamedAdviceResponse.add(_formatAdvice(response));

        // JSON 데이터 수집 완료 여부 확인
        if (_isJsonCollectionComplete(jsonResponse, isCollectingJson)) {
          final feedbackResponse = _parseAndHandleJsonResponse(
            jsonResponse: jsonResponse,
            feedback: _formatAdvice(response),
            param: param,
          );

          jsonResponse = ''; // JSON 수집 상태 초기화
          isCollectingJson = false;

          return param.onFeedBackCompleted(feedbackResponse: feedbackResponse);
        }
      },
      onDone: () {
        /// 응답이 종료된 이후
        /// 1) Stream 닫기
        /// 2) 응답 진행 상태 초기화
        state = AiAnswerProgress.init;
        streamedAdviceResponse.close();
      },
    );

    return streamedAdviceResponse;
  }

  /// 프롬프트 메세지 히스토리를 만드는 함수
  /// 추후에 메세지 히스토리 기반으로 채팅을 구현할 수도 있을 것 같아 따로 분리했습니다.
  List<Map<String, dynamic>> _createChatMessage(
      GetQuestionFeedbackParam param) {
    // 프롬프트는 추후 전부 한 언어로 통일할 것이므로 따로 localization은 필요하지 않아 보입니다.
    return [
      Messages(
        role: Role.system,
        content:
            '면접 질문을 물어보고 유저 답변의 정답 여부를 확인합니다. 당신은 면접관, 유저는 지원자입니다. 이제부터 진행할 면접은 ${StoredTopics.getById(param.qna.qna.id.getFirstPartOfSpliited).text}와 관련된 질문입니다. ${AppLocale.currentLocale.languageCode}언어로 면접을 진행합니다. 답변은 의무문으로 끝나면 안됩니다',
      ).toJson(),
      ...param.chatHistory.map(
        (element) => switch (element) {
          QuestionChatEntity() => Messages(
              role: Role.assistant,
              content: element.message.value,
            ).toJson(),
          FeedbackChatEntity() => Messages(
              role: Role.assistant,
              content: element.message.value,
            ).toJson(),
          AnswerChatEntity() => Messages(
              role: Role.user,
              content: element.message.value,
            ).toJson(),
          _ => Messages(
              role: Role.assistant,
              content: element.message.value,
            ).toJson()
        },
      ),
      Messages(
        role: Role.system,
        content:
            '면접 질문에 대한 모범답안은 다음과 같습니다: ${param.qna.qna.answers.map((str) => '-$str').join(' ')}',
      ).toJson(),
      Messages(
        role: Role.system,
        content:
            '먼저 반드시 면접자의 답변에 대한 조언을 80글자 이내의 문자열 형태로 제공해야 합니다. 조언 가장 앞에 면접자의 답변이 틀렸다면 [w]를, 답변이 맞았다고 판단되면 [c]를 붙입니다. 조언을 제공한 다음, 유저의 답변을 평가하여 JSON형식으로 0~5점 사이의 점수와, 꼬리질문 필요 여부를 제공해주세요. 꼬리질문은 유저의 면접 답변을 기반으로 면접관이 제시한 질문에 대해 확실하고 심화적인 이해를 가지고 있는지 확인하기 위해 필요합니다. JSON 형식은 {"score": "점수", "isFollowUpQuestionNeeded": "꼬리 질문 필요 여부", }입니다. score과 isFollowUpQuestionNeeded는 필수값입니다',

        /// 꼬리질문까지 생성할 경우 프롬프트 - 추후에 꼬리질문 usecase에서 사용하기 위해 임시 주석해두었습니다.
        /* '먼저 유저의 답변에 대한 피드백을 80글자 이내의 문자열 형태로 반드시 제공해야 합니다. 조언 가장 앞에 면접자의 답변이 틀렸다면 [w]를, 답변이 맞았다고 판단되면 [c]를 붙입니다. 조언을 제공한 다음, 유저의 답변에 대한 점수를 0~5점까지로 매긴 뒤 점수가 1점 이상이고 면접자가 주제에 대한 심화적인 이해를 가지고 있는지 확인하기 위한 꼬리질문이 필요할 경우 JSON 형식으로 0~5점 사이의 점수, 꼬리질문, 꼬리질문이 필요한 이유를 제공해주세요. 꼬리질문은 제시된 질문과 연관이 있어야 합니다. JSON 형식은 {"score": 점수, "followUpQuestion": "꼬리 질문", "cause": "꼬리질문이 나온 이유" }입니다. score은 필수값입니다' */
      ).toJson(),
    ];
  }

  bool _isStartingJsonCollection(String chunk, bool isCollectingJson) {
    return !isCollectingJson && chunk.contains('{');
  }

  bool _isJsonCollectionComplete(String jsonResponse, bool isCollectingJson) {
    return isCollectingJson && jsonResponse.contains('}');
  }

  FeedbackResponseEntity _parseAndHandleJsonResponse(
      {required String jsonResponse,
      required String feedback,
      required GetQuestionFeedbackParam param}) {
    try {
      final parsedData = jsonDecode(jsonResponse) as Map<String, dynamic>;
      return FeedbackResponseEntity.fromJson(
        parsedData,
        feedback,
        param.qna,
        param.chatHistory,
        param.userName,
      );
    } catch (e) {
      return FeedbackResponseEntity(
        feedback: feedback,
        score: 0,
        isFollowUpQuestionNeeded: false,
        topicQuestion: param.qna,
        userName: param.userName,
        relatedChatHistory: param.chatHistory,
      );
    }
  }

  ///
  /// 정답 여부를 확인하는 메소드
  ///
  void _setCorrectnessIfNeeded(
    String response,
    void Function({required AnswerState answerState}) checkAnswer,
  ) {
    if (!state.isOnProgress) return;

    late final AnswerState answerState;

    // 모든 AnswerState 값을 순회하면서 적절한 상태를 찾음
    answerState = AnswerState.values.firstWhere(
      (state) => response.contains(state.tag),
      orElse: () => AnswerState.loading,
    );

    switch (answerState) {
      case AnswerState.loading:
        break;
      case AnswerState.initial:
      case AnswerState.error:
      case AnswerState.correct:
      case AnswerState.wrong:
      case AnswerState.inappropriate:
        HapticFeedback.lightImpact();
        state = AiAnswerProgress.completed;
        checkAnswer.call(answerState: answerState);
    }
  }

  /// 응답값 포맷
  /// 1. [c] & [w] 인디에키터 포맷, [AnswerState]
  /// 2. 불필요 줄바꿈 제거
  String _formatAdvice(String response) {
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

/// [SetAiFeedbackUseCase] 파라미터
typedef GetQuestionFeedbackParam = ({
  List<BaseChatEntity> chatHistory,
  ChatQnaEntity qna,
  String userName,
  void Function(
      {required FeedbackResponseEntity feedbackResponse}) onFeedBackCompleted,
  void Function({required AnswerState answerState}) checkAnswer,
  void Function(Object error, StackTrace startTrace) onError,
});
