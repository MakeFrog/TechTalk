import 'dart:async';
import 'dart:developer';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';

/// AI를 사용하여 꼬리질문을 생성하는 use case
class SetAiFollowUpQuestionUseCase extends BaseNoFutureUseCase<
    GetFollowUpQuestionParam, Result<BehaviorSubject<String>>> {
  AiAnswerProgress state = AiAnswerProgress.init;

  @override
  Result<BehaviorSubject<String>> call(GetFollowUpQuestionParam param) {
    final BehaviorSubject<String> streamedAdviceResponse =
        BehaviorSubject<String>();
    state = AiAnswerProgress.onProgress;

    String response = '';

    try {
      OpenAI.instance
          .onChatCompletionSSE(
        request: ChatCompleteText(
          functionCall: FunctionCall.auto,
          messages: _createChatMessage(
            chatHistory: param.chatHistory,
            rootQna: param.rootQna,
          ),
          maxToken: 300,
          model: Gpt4ChatModel(),
          temperature: 0.5,
          stream: true,
          user: FirebaseAuth.instance.currentUser!.uid,
        ),
      )  .transform(
        StreamTransformer.fromHandlers(
          handleError: (error, stackTrace, sink) {
            param.onError(error, stackTrace);
          },
        ),
      ).listen(
        cancelOnError: true,
        (it) {
          it as ChatResponseSSE;
          response += it.choices?.last.message?.content ?? '';

          if (response.isEmpty) return;

          log(response);

          streamedAdviceResponse.add(_formatQuestion(response));
        },
        onDone: () {
          /// 응답이 종료된 이후
          /// 1) Stream 닫기
          /// 2) 응답 진행 상태 초기화
          state = AiAnswerProgress.init;
          streamedAdviceResponse.close();
          return param.onFollowUpQuestionCompleted(
            followUpQuestion: _formatQuestion(response),
          );
        },
      );
      return Result.success(streamedAdviceResponse);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  List<Map<String, dynamic>> _createChatMessage(
      {required List<BaseChatEntity> chatHistory,
      required ChatQnaEntity rootQna}) {
    // 프롬프트는 추후 전부 한 언어로 통일할 것이므로 따로 localization은 필요하지 않아 보입니다.
    return [
      Messages(
        role: Role.system,
        content:
            '당신은 면접관, 유저는 지원자입니다. 유저의 마지막 답변을 기반으로 적절한 꼬리질문(연관질문)을 제공합니다.면접주제는 ${StoredTopics.getById(rootQna.qna.id.getFirstPartOfSpliited).text} 프로그래밍 입니다. 꼬리 질문은 유저의 면접 질문 답변에 대해 심화적이고 날카로운 질문을 제공하세요. ${AppLocale.currentLocale.languageCode}언어로 꼬리질문을 생성하세요.',
      ).toJson(),
      ...chatHistory.map(
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
    ];
  }

  String _formatQuestion(String response) {
    String formattedText = response.replaceAll('\n', '').trim();

    if (formattedText.length <= 3) return '';

    return formattedText;
  }
}

/// [SetAiFollowUpQuestionUseCase] 파라미터
typedef GetFollowUpQuestionParam = ({
  List<BaseChatEntity> chatHistory,
  ChatQnaEntity rootQna,
  String userName,
  void Function({required String followUpQuestion}) onFollowUpQuestionCompleted,
  void Function(Object error, StackTrace startTrace) onError,
});
