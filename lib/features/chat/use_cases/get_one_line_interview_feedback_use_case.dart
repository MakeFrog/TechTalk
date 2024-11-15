import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/subjects.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';

class GetOneLineInterViewFeedbackUseCase extends BaseNoFutureUseCase<
    GetOneLineInterViewFeedbackParam, BehaviorSubject<String>> {
  AiAnswerProgress state = AiAnswerProgress.init;

  @override
  BehaviorSubject<String> call(GetOneLineInterViewFeedbackParam param) {
    final BehaviorSubject<String> streamedAdviceResponse =
        BehaviorSubject<String>();
    String response = '';
    state = AiAnswerProgress.onProgress;
    runZonedGuarded(() {
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
        // NOTE: 희한하게 openAI에ㅓ 429 에러같은게 뜨면 여기서는 안잡힌다.
        onError: param.onError,
        cancelOnError: true,
        (it) {
          it as ChatResponseSSE;
          final chunk = it.choices?.last.message?.content ?? '';

          if (chunk.isEmpty) return;
          response += chunk;
          streamedAdviceResponse.add(response);
        },
        onDone: () {
          /// 응답이 종료된 이후
          /// 1) Stream 닫기
          /// 2) 응답 진행 상태 초기화
          state = AiAnswerProgress.init;
          streamedAdviceResponse.close();
        },
      );
    }, (error, stackTrace) {
      param.onError(error, stackTrace);
    });

    return streamedAdviceResponse;
  }

  /// 프롬프트 메세지 히스토리를 만드는 함수
  /// 추후에 메세지 히스토리 기반으로 채팅을 구현할 수도 있을 것 같아 따로 분리했습니다.
  List<Map<String, dynamic>> _createChatMessage(
      GetOneLineInterViewFeedbackParam param) {
    // 프롬프트는 추후 전부 한 언어로 통일할 것이므로 따로 localization은 필요하지 않아 보입니다.
    return [
      Messages(
        role: Role.system,
        content:
            '면접관으로서 아래 개발자 면접 채팅 기록을 기반으로 종합적인 한 줄 평 피드백을 제공해야 합니다. 면접 주제는 ${param.topic.map((e) => '${StoredTopics.getById(e.id).text}').join(' ')}입니다. 피드백은 ${AppLocale.currentLocale.languageCode} 언어로 제공합니다.',
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
    ];
  }
}

/// [GetOneLineInterViewFeedbackUseCase] 파라미터
class GetOneLineInterViewFeedbackParam {
  final List<TopicEntity> topic;
  final List<BaseChatEntity> chatHistory;
  final InterviewResult interviewResult;
  final void Function(Object error, StackTrace startTrace) onError;

  const GetOneLineInterViewFeedbackParam({
    required this.chatHistory,
    required this.interviewResult,
    required this.topic,
    required this.onError,
  });
}
