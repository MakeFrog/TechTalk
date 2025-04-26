import 'dart:async';
import 'dart:developer';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/chat/repositories/entities/proficiency_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_interview_room_entity.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';

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
            type: param.interviewType,
            youtubeExtra: param.youtubeExtra,
          ),
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

  List<Map<String, dynamic>> _createChatMessage({
    required List<BaseChatEntity> chatHistory,
    required ChatQnaEntity rootQna,
    required InterviewType type,
    required YoutubeInterviewRoomEntity? youtubeExtra,
  }) {
    // 프롬프트는 추후 전부 한 언어로 통일할 것이므로 따로 localization은 필요하지 않아 보입니다.
    return [
      Messages(
        role: Role.system,
        content: '당신은 면접관입니다. 아래 채팅 히스토리를 참고하여 면접자의 답변에 대한 꼬리질문을 생성해주세요.',
      ).toJson(),
      type.typedBranch(
        common: (_) {
          return Messages(
            role: Role.system,
            content:
                '면접주제는 ${StoredTopics.getById(rootQna.qna.id.getFirstPartOfSpliited).text} 프로그래밍 입니다.',
          ).toJson();
        },
        resume: (_) {
          return Messages(
            role: Role.system,
            content: '유저의 개발자 이력서와 포트폴리오를 기반으로 면접 질문을 물어보았습니다',
          ).toJson();
        },
        youtube: (_) {
          return Messages(
                  role: Role.system,
                  content:
                      ' ${youtubeExtra?.contentTitle}라는 제목의 유튜브 프로그래밍 콘텐츠를 기반해 제시된 면접 질문입니다')
              .toJson();
        },
        proficiency: (InterviewType type) {
          return Messages(
            role: Role.system,
            content:
                '면접주제는 ${TechSetEntity.mappedFromId((rootQna.qna as ProficiencyQnaEntity).techSetId).name} 프로그래밍 입니다.',
          ).toJson();
        },
      ),
      Messages(
        role: Role.system,
        content: '꼬리 질문은 유저의 면접 질문 답변에 대해 심화적이고 날카로운 질문을 제공하세요',
      ).toJson(),
      Messages(
        role: Role.system,
        content: '''### 꼬리질문 생성 규칙  
1. 면접자의 이전 답변을 기반으로 심화적인 질문을 생성
2. 면접자의 답변에서 부족하거나 모호한 부분을 짚어내는 질문
3. 실제 기술 면접에서 사용할 수 있는 수준의 질문
4. 면접자의 답변과 직접적으로 연관된 질문만 생성
5. 이전 대화의 맥락을 고려하여 자연스럽게 이어지는 문장으로 구성
6. ${AppLocale.currentLocale.languageCode}언어로 질문 생성

### 채팅 히스토리
${chatHistory.map((element) => switch (element) {
                  QuestionChatEntity() => '면접관: ${element.message.value}',
                  FeedbackChatEntity() => '면접관 피드백: ${element.message.value}',
                  AnswerChatEntity() => '면접자: ${element.message.value}',
                  _ => '면접관: ${element.message.value}'
                }).join('\n')}''',
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
  InterviewType interviewType,
  List<BaseChatEntity> chatHistory,
  ChatQnaEntity rootQna,
  String userName,
  YoutubeInterviewRoomEntity? youtubeExtra,
  void Function({required String followUpQuestion}) onFollowUpQuestionCompleted,
  void Function(Object error, StackTrace startTrace) onError,
});
