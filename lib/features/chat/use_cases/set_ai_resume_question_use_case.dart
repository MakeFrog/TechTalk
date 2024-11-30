import 'dart:async';
import 'dart:convert';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';

import 'package:techtalk/features/chat/repositories/enums/resume_question_type.enum.dart';

class SetAiResumeQuestionUseCase
    extends BaseUseCase<GetResumeParam, Result<List<ResumeQnaEntity>>> {
  @override
  Future<Result<List<ResumeQnaEntity>>> call(GetResumeParam request) async {
    try {
      
      // GPT 응답을 대기
      final response = await OpenAI.instance.onChatCompletion(
        request: ChatCompleteText(
          messages: createResumeChatMessage(request),
          functionCall: FunctionCall.auto,
          maxToken: 300,
          temperature: 0.5,
          user: FirebaseAuth.instance.currentUser!.uid,
          model: Gpt4ChatModel(),
        ),
      );

      // JSON 파싱 및 결과 매핑
      final parsedResponse = jsonDecode(response!.choices[0].message!.content);
      final List<ResumeQnaEntity> qnaList = (parsedResponse as List)
          .map((json) => ResumeQnaEntity(
                id: json['id'] ?? '',
                question: json['question'],
                questionType: json['type'] == 'hardSkill'
                    ? ResumeQuestionType.hardSkill
                    : ResumeQuestionType.softSkill,
                evaluationPoint: json['evaluationPoint'] ?? '',
              ))
          .toList();

      // 성공적으로 결과 반환
      return Result.success(qnaList);
    } catch (error) {
      // 에러 발생 시 Exception으로 변환하여 Result.failure로 반환
      return Result.failure(Exception(error.toString()));
    }
  }

  /// GPT 프롬프트 메시지 생성
  List<Map<String, dynamic>> createResumeChatMessage(GetResumeParam request) {
    final String promptContent = '''
  당신은 이력서 및 포트폴리오 분석을 도와주는 전문가입니다. 아래는 지원자의 이력서 내용입니다:

  "${request.resumeOrPortfolioContent}"

  이 내용을 바탕으로 하드스킬(기술적 역량)과 소프트스킬(비기술적 역량)을 구분하여 질문을 작성하세요. 질문은 아래 형식을 따르세요:

  [
    {
      "question": "Flutter와 네이티브 코드를 통합하여 로그인 기능을 구현한 사례를 설명해주세요.",
      "type": "hardSkill",
      "evaluationPoint": "Flutter와 네이티브 통합 기술, Firebase Auth 활용 능력"
    },
    {
      "question": "팀 협업 과정에서 어려움을 겪었을 때 이를 어떻게 극복했는지 설명해주세요.",
      "type": "softSkill",
      "evaluationPoint": "협업 능력, 갈등 해결 및 문제 극복 역량"
    }
  ]

  작성 규칙:
  1. 질문 유형은 "hardSkill" 또는 "softSkill" 중 하나여야 합니다.
  2. 각 질문마다 "question", "type", "evaluationPoint" 필드를 포함해야 합니다.
  3. 지원자의 경험과 기술에 맞는 현실적이고 구체적인 질문을 작성해주세요.
  ''';

    return [
      {"role": "system", "content": promptContent},
      {"role": "user", "content": "위 내용을 바탕으로 질문을 작성해주세요."},
    ];
  }
}

/// 파라미터
typedef GetResumeParam = ({
  String resumeOrPortfolioContent,
});
