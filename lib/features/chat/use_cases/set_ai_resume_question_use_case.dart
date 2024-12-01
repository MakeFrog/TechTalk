import 'dart:async';
import 'dart:convert';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';

import 'package:techtalk/features/chat/repositories/enums/resume_question_type.enum.dart';

class SetAiResumeQuestionUseCase
    extends BaseUseCase<GetResumeParam, Result<List<ResumeQnaEntity>>> {
  @override
  Future<Result<List<ResumeQnaEntity>>> call(GetResumeParam request) async {
    try {
      // GPT 응답 대기
      final response = await OpenAI.instance.onChatCompletion(
        request: ChatCompleteText(
          messages: createResumeChatMessage(request),
          maxToken: 800,
          temperature: 0.5,
          user: FirebaseAuth.instance.currentUser!.uid,
          model: Gpt4OChatModel(),
        ),
      );

      // 응답의 토큰 정보 출력
      if (response != null) {
        final totalTokens = response.usage?.totalTokens ?? 0;
        final promptTokens = response.usage?.promptTokens ?? 0;
        final completionTokens = response.usage?.completionTokens ?? 0;

        debugPrint('===== 토큰 사용량 =====');
        debugPrint('총 토큰 수: $totalTokens');
        debugPrint('프롬프트 토큰 수: $promptTokens');
        debugPrint('완성 토큰 수: $completionTokens');
      } else {
        debugPrint('GPT 응답이 없습니다.');
      }

      // JSON 파싱 및 결과 매핑
      final parsedResponse = jsonDecode(response!.choices[0].message!.content);
      final List<ResumeQnaEntity> qnaList = (parsedResponse as List)
          .map(
            (json) => ResumeQnaEntity(
              id: json['id'] ?? '',
              question: json['question'],
              questionType: json['type'] == 'hardSkill'
                  ? ResumeQuestionType.hardSkill
                  : ResumeQuestionType.softSkill,
              evaluationPoint: json['evaluationPoint'] ?? '',
            ),
          )
          .toList();

      debugPrint(
        const JsonEncoder.withIndent('').convert(
          qnaList.map((qna) {
            return {
              "id": qna.id,
              "question": qna.question,
              "type": qna.questionType == ResumeQuestionType.hardSkill
                  ? "hardSkill"
                  : "softSkill",
              "evaluationPoint": qna.evaluationPoint,
            };
          }).toList(),
        ),
      );

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
  당신은 개발자를 채용하는 회사의 채용 전문가입니다. 아래는 회사에 지원한 지원자의 이력서와 포트폴리오 내용입니다.

  이력서와 포트폴리오의 내용은 지원자의 주요 기술 스택, 프로젝트 기여도, 그리고 문제 해결 과정에 초점을 맞추고 있습니다.
  질문 작성 시 지원자가 수행한 프로젝트, 해결한 도전 과제, 적용한 기술과 관련된 맥락을 반영하세요.

  이력서 내용
  "${request.resumeContent}"

  포트폴리오 내용
  "${request.portfolioContent}"

  작성 규칙:
  - 총 질문의 개수는 4~8개이며, 이력서와 포트폴리오의 내용에 따라 달라집니다.
  - 질문은 기술적 역량, 비즈니스 성과, 협업 방식, 창의적 문제 해결 능력 등을 평가할 수 있도록 다양하게 작성하세요.
  - 하드스킬 질문은 기술의 사용 사례, 문제 해결 과정, 성과에 대해 묻도록 작성하세요.
  - 소프트스킬 질문은 팀 협업, 프로젝트 관리, 의사소통 능력 등을 평가할 수 있는 내용으로 작성하세요.
  - 평가 기준(evaluationPoint)은 지원자의 역량을 평가할 구체적인 기술적/소프트스킬 기준을 포함하며, 50자 이내로 작성하세요.

  예시:
  [
    {
      "question": "클린 아키텍처를 적용하여 코드 리뷰 시간을 단축한 방법을 설명해주세요.",
      "type": "hardSkill",
      "evaluationPoint": "클린 아키텍처 이해도, 코드 품질 개선 능력"
    },
    {
      "question": "팀 프로젝트에서 UI/UX 개선을 위해 디자이너와 협력한 경험을 공유해주세요.",
      "type": "softSkill",
      "evaluationPoint": "팀 협업 능력, 창의적 문제 해결 능력"
    }
  ]
  ''';

    return [
      {"role": "system", "content": promptContent},
      {"role": "user", "content": "위 내용을 바탕으로 질문을 작성해주세요."},
    ];
  }
}

/// 파라미터
typedef GetResumeParam = ({String resumeContent, String portfolioContent});
