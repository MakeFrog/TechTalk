import 'dart:ui';

import 'package:chatgpt_completions/chatgpt_completions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/_backup/domain/base/base_no_future_use_case.dart';

/** Created By Ximya - 2023.05.06
 *  ChatGPT 요청 및 응답을 관리하는 useCase 모듈
 *  [BehaviorSubject] 객체를 반환하여
 *  View레이어에서 독립적인 Stream 이벤트를 fetch 할 수 있도록 함.
 * */

enum ReplyState {
  init,
  checking,
  answerChecked,
}

class GetGptReplyUseCase extends BaseNoFutureUseCase<
    ({
      String category,
      String question,
      String userAnswer,
      VoidCallback onStreamDone,
      void Function(bool) checkAnswer
    }),
    BehaviorSubject<String>> {
  final ChatGPTCompletions completions = ChatGPTCompletions.instance;
  ReplyState state = ReplyState.init;

  /// ChatGpt 응답을 요청하는 메소드
  /// [BehaviorSubject]을 리턴하여 독립적인 Stream 객체를 반환/
  @override
  BehaviorSubject<String> call(
      ({
        String category,
        void Function(bool) checkAnswer,
        VoidCallback onStreamDone,
        String question,
        String userAnswer
      }) request) {
    final BehaviorSubject<String> messageSubject = BehaviorSubject<String>();
    state = ReplyState.checking;

    final prompt =
        '${request.category} 프로그래밍 분야에서 "${request.question}"라는 프로그래밍 질문에,\n"${request.userAnswer}" 라고 답한다면 옳은 답변일까?\n정답이라면 "[correct]" 오답이라면 "[wrong]"라는 태그 단어를 문장 맨 앞에 붙여주고 이유도 간략하게 설명해줘.';
    completions.textCompletions(
      TextCompletionsParams(
        prompt: prompt,
        model: GPTModel.davinci,
        temperature: 0.2,
        topP: 1,
        n: 1,
        stream: true,
        maxTokens: 500,
      ),
      onStreamValue: (response) {
        setCorrectness(response, request.checkAnswer);
        final filteredRes = formatString(response);
        messageSubject.add(filteredRes);
        print(response);
      },
    ).then((_) {
      messageSubject.close();
      state = ReplyState.init;
      request.onStreamDone();
    });

    return messageSubject;
  }

  /// 정답 여부 확인 상태 변경
  void setCorrectness(String response, Function(bool) checkAnswer) {
    if (state == ReplyState.checking && response.length >= 10) {
      if (response.contains("[wrong]")) {
        checkAnswer(false);
      } else {
        checkAnswer(true);
      }

      state = ReplyState.answerChecked;
    }
  }

  /// 문자열 포맷
  /// 1. [incorrect] & [correct] 인디에키터 포맷
  /// 2. 불필요 줄바꿈 제거
  /// TODO: prompt를 고도화하면 해당 포맷 로직을 생략시킬 수 있을 듯
  String formatString(String response) {
    String originText = response.replaceAll("\n", '');

    if (originText.contains("[wrong]")) {
      String cleanedText = originText.replaceFirst("[wrong]", "").trim();
      return "[오답]\n$cleanedText";
    } else {
      String cleanedText = originText.replaceFirst("[correct]", "").trim();
      return "[정답]\n$cleanedText";
    }
  }

  // Chat GPT 인스턴스 초기화
  void initUseCase() {
    ChatGPTCompletions.instance.initialize(apiKey: dotenv.env['OPENAPI_KEY']!);
  }
}