import 'dart:convert';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';

class SetAiFeedbackUseCase extends BaseNoFutureUseCase<GetQuestionFeedbackParam, Result<BehaviorSubject<String>>> {
  FeedbackProgress state = FeedbackProgress.init;

  @override
  Result<BehaviorSubject<String>> call(GetQuestionFeedbackParam param) {
    final BehaviorSubject<String> streamedAdviceResponse = BehaviorSubject<String>();
    state = FeedbackProgress.onProgress;

    String response = '';
    String jsonResponse = '';
    bool isCollectingJson = false;

    try {
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
          .listen(
        (it) {
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
          streamedAdviceResponse.add(formatResponse(response));

          // JSON 데이터 수집 완료 여부 확인
          if (_isJsonCollectionComplete(jsonResponse, isCollectingJson)) {
            final feedback = _parseAndHandleJsonResponse(jsonResponse);
            // TODO: 임시로 확인을 위해 출력, 추후 피드백 핸들링 추가 예정
            print('score: ${feedback.score}\nfollowingQ: ${feedback.followUpQuestion}\ncause: ${feedback.cause}');

            jsonResponse = ''; // JSON 수집 상태 초기화
            isCollectingJson = false;
          }
        },
        onDone: () {
          /// 응답이 종료된 이후
          /// 1) Stream 닫기
          /// 2) 응답 진행 상태 초기화
          /// 3) 완료 콜백 메소드 실행
          state = FeedbackProgress.init;
          streamedAdviceResponse.close().then((_) {
            String? streamedRes = streamedAdviceResponse.valueOrNull;

            if (streamedRes == null) {
              return;
            } else {
              return param.onFeedBackCompleted(
                formatResponse(streamedAdviceResponse.value),
              );
            }
          });
        },
      );
      return Result.success(streamedAdviceResponse);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  /// 프롬프트 메세지 히스토리를 만드는 함수
  /// 추후에 메세지 히스토리 기반으로 채팅을 구현할 수도 있을 것 같아 따로 분리했습니다.
  List<Map<String, dynamic>> _createChatMessage(GetQuestionFeedbackParam param) {
    // 프롬프트는 추후 전부 한 언어로 통일할 것이므로 따로 localization은 필요하지 않아 보입니다.
    return [
      Messages(
        role: Role.system,
        content:
            '면접 질문을 물어보고 유저 답변의 정답 여부를 확인합니다. 당신은 면접관, 유저는 지원자입니다. 이제부터 진행할 면접은 ${StoredTopics.getById(param.qna.qna.id.getFirstPartOfSpliited)}와 관련된 질문입니다. 지원자의 이름은 \'${param.userName}\'입니다. 유저를 지칭할 때 항상 이름으로 불러주세요. ${AppLocale.currentLocale.languageCode}언어로 면접을 진행합니다.',
      ).toJson(),
      Messages(role: Role.assistant, content: param.question).toJson(),
      Messages(
        role: Role.user,
        content: param.userAnswer,
      ).toJson(),
      Messages(
        role: Role.system,
        content: '면접 질문에 대한 모범답안은 다음과 같습니다: ${param.qna.qna.answers.map((str) => '-$str').join(' ')}',
      ).toJson(),
      Messages(
        role: Role.system,
        content:
            '먼저 유저의 답변에 대한 피드백을 80글자 이내의 문자열 형태로 반드시 제공해야 합니다. 조언 가장 앞에 면접자의 답변이 틀렸다면 [w]를, 답변이 맞았다고 판단되면 [c]를 붙입니다. 조언을 제공한 다음, 유저의 답변에 대한 점수를 0~5점까지로 매긴 뒤 점수가 1점 이상이고 면접자가 주제에 대한 심화적인 이해를 가지고 있는지 확인하기 위한 꼬리질문이 필요할 경우 JSON 형식으로 0~5점 사이의 점수, 꼬리질문, 꼬리질문이 필요한 이유를 제공해주세요. 꼬리질문은 제시된 질문과 연관이 있어야 합니다. JSON 형식은 {"score": 점수, "followUpQuestion": "꼬리 질문", "cause": "꼬리질문이 나온 이유" }입니다.',
      ).toJson(),
    ];
  }

  bool _isStartingJsonCollection(String chunk, bool isCollectingJson) {
    return !isCollectingJson && chunk.contains('{');
  }

  bool _isJsonCollectionComplete(String jsonResponse, bool isCollectingJson) {
    return isCollectingJson && jsonResponse.contains('}');
  }

  FeedbackResponse _parseAndHandleJsonResponse(String jsonResponse) {
    final parsedData = _parseJsonResponse(jsonResponse);
    return FeedbackResponse.fromJson(parsedData);
  }

  /// 응답에서 점수와 꼬리질문을 JSON 형식으로 파싱하는 함수
  Map<String, dynamic> _parseJsonResponse(String response) {
    try {
      return jsonDecode(response) as Map<String, dynamic>;
    } catch (e) {
      return {
        "score": 0,
        "followUpQuestion": null,
      };
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
        state = FeedbackProgress.completed;
        checkAnswer.call(answerState: answerState);
    }
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

// TODO: 추후에 클래스 정리하면서 꼬리질문 UI 구현시 사용 예정, 임시로 여기 위치시키겠습니다.
/// JSON 응답을 담을 클래스
class FeedbackResponse {
  final int score;
  final String? followUpQuestion;
  final String? cause;

  FeedbackResponse({
    required this.score,
    this.followUpQuestion,
    this.cause,
  });

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) {
    return FeedbackResponse(
      score: json['score'],
      followUpQuestion: json['followUpQuestion'],
      cause: json['cause'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'followUpQuestion': followUpQuestion,
    };
  }
}

/// [SetAiFeedbackUseCase] 파라미터
typedef GetQuestionFeedbackParam = ({
  ChatQnaEntity qna,
  String question,
  String userAnswer,
  String userName,
  void Function(String feedback) onFeedBackCompleted,
  void Function({required AnswerState answerState}) checkAnswer
});
