import 'dart:async';
import 'dart:convert';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/resume_question_type.enum.dart';

/// 파라미터
typedef GetResumeParam = ({String resumeContent, String portfolioContent});

class CreateOpenAIResumeQuestionUseCase
    extends BaseUseCase<GetResumeParam, Result<List<ResumeQnaEntity>>> {
  @override
  Future<Result<List<ResumeQnaEntity>>> call(GetResumeParam request) async {
    try {
      // GPT 응답 대기
      final response = await OpenAI.instance.onChatCompletion(
        request: ChatCompleteText(
          messages: _createResumeChatMessage(request),
          maxToken: 1000,
          temperature: 0.5,
          user: FirebaseAuth.instance.currentUser!.uid,
          model: Gpt4OChatModel(),
        ),
      );

      // 응답과 메시지에 대한 예외처리
      if (response == null) {
        throw Exception('GPT 응답이 없습니다.');
      }
      if (response.choices.isEmpty ||
          response.choices[0].message == null ||
          response.choices[0].message!.content.isEmpty) {
        throw Exception('GPT 응답 메시지가 없습니다.');
      }

      // 예외 처리 조건을 거친 응답
      final rawContent = response.choices[0].message!.content;

      try {
        // JSON 파싱 및 결과 매핑
        final parsedResponse = jsonDecode(rawContent);
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

        // 디버깅용 프롬프트 출력
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

        return Result.success(qnaList);
      }

      // 실패 예외처리
      on FormatException catch (e) {
        debugPrint('JSON 포맷 오류: $e');

        return Result.failure(
          Exception('응답을 처리할 수 없습니다. 다시 시도해주세요.'),
        );
      }
    } catch (error) {
      return Result.failure(Exception(error.toString()));
    }
  }

  /// GPT 프롬프트 메시지 생성
  List<Map<String, dynamic>> _createResumeChatMessage(GetResumeParam request) {
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
      "id": "Q1"
      "question": "클린 아키텍처를 적용하여 코드 리뷰 시간을 단축한 방법을 설명해주세요.",
      "type": "hardSkill",
      "evaluationPoint": "클린 아키텍처 이해도, 코드 품질 개선 능력"
    },
    {
      "id": "Q2"
      "question": "팀 프로젝트에서 UI/UX 개선을 위해 디자이너와 협력한 경험을 공유해주세요.",
      "type": "softSkill",
      "evaluationPoint": "팀 협업 능력, 창의적 문제 해결 능력"
    }
  ]
  ''';

    return [
      {"role": "system", "content": promptContent},
    ];
  }
}


///
/// TODO: openai에 적용할 resume_manage_event 코드 (yundal)
///
  ///
  /// 문서 저장하기
  ///
  // Future<void> saveDocuments(WidgetRef ref) async {
  //   final state = ref.read(resumeInfoProvider);
  //   final doc = state.requireValue;
  //   if (doc == null) {
  //     debugPrint('문서 정보가 존재하지 않습니다.');
  //     return;
  //   }

  //   final Directory tempDir = await getTemporaryDirectory();
  //   final Directory permanentDir = await getApplicationDocumentsDirectory();

  //   final tempResume = doc.resume;
  //   final tempPortfolio = doc.portfolio;

  //   // --- 이력서 처리 로직 ---
  //   if (tempResume != null && tempResume.path != null) {
  //     // 이미 영구 디렉토리에 있는지 확인
  //     if (tempResume.path!.startsWith(tempDir.path)) {
  //       // 임시 경로이므로, 영구 디렉토리로 복사
  //       final String? fileName = tempResume.title; // 확장자 없는 파일명
  //       final String newResumePath = '${permanentDir.path}/$fileName.pdf';

  //       try {
  //         // (1) 파일 복사
  //         await File(tempResume.path!).copy(newResumePath);
  //         // (2) 임시 파일 삭제
  //         await File(tempResume.path!).delete();

  //         // (3) ResumeEntity 업데이트
  //         final updatedResume = ResumeEntity(
  //           path: newResumePath,
  //           title: tempResume.title,
  //           uploadAt: tempResume.uploadAt,
  //         );

  //         // (4) resumeInfoProvider 업데이트
  //         await ref
  //             .read(resumeInfoProvider.notifier)
  //             .updateDocumentState(DocumentType.resume, updatedResume);
  //       } catch (e) {
  //         debugPrint('이력서 영구 경로 이동 실패: $e');
  //       }
  //     } else {
  //       // 이미 영구 경로라면, 별도 저장 로직 스킵
  //       debugPrint('이미 영구 디렉토리에 저장된 이력서입니다. 추가 작업 스킵');
  //     }
  //   }

  //   // --- 포트폴리오 처리 로직 ---
  //   if (tempPortfolio != null && tempPortfolio.path != null) {
  //     // 이미 영구 디렉토리에 있는지 확인
  //     if (tempPortfolio.path!.startsWith(tempDir.path)) {
  //       final String? fileName = tempPortfolio.title;
  //       final String newPortfolioPath = '${permanentDir.path}/$fileName.pdf';

  //       try {
  //         await File(tempPortfolio.path!).copy(newPortfolioPath);
  //         await File(tempPortfolio.path!).delete();

  //         final updatedPortfolio = PortfolioEntity(
  //           path: newPortfolioPath,
  //           title: tempPortfolio.title,
  //           uploadAt: tempPortfolio.uploadAt,
  //         );

  //         await ref
  //             .read(resumeInfoProvider.notifier)
  //             .updateDocumentState(DocumentType.portfolio, updatedPortfolio);
  //       } catch (e) {
  //         debugPrint('포트폴리오 영구 경로 이동 실패: $e');
  //       }
  //     } else {
  //       debugPrint('이미 영구 디렉토리에 저장된 포트폴리오입니다. 추가 작업 스킵');
  //     }
  //   }

  //   // --- 모든 저장 로직 호출 (Repository에 반영)
  //   await ref.read(resumeInfoProvider.notifier).saveCurrentDocumentState();
  // }