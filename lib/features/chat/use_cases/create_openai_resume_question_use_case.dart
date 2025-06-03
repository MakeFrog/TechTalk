import 'dart:async';
import 'dart:convert';
import 'package:dart_openai/dart_openai.dart';
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
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          '''
      [type: system | content:
      당신은 개발자를 채용하는 회사의 채용 전문가(Interviewer)입니다. 
      지원자의 이력서와 포트폴리오 정보를 바탕으로, 
      지원자에게 질문을 작성하려고 합니다.

      목표:
      - 질문을 통해 지원자의 '기술 역량(hard skills)'과 '협업 능력, 문제 해결 능력(soft skills)'을 파악한다.
      - 작성된 질문은 지원자의 이력서 및 포트폴리오 내용에 기반하여, 구체적이고 실제 인터뷰 상황에서 도움이 되는 수준으로 구성한다.

      주의사항:
      1. 작성된 질문은 회사에서 현업 개발자를 뽑을 때 고려하는 요소(프로젝트 기여도, 문제 해결 능력, 코드 품질 등)에 집중한다.
      2. 질문은 하드스킬/소프트스킬 종류별로 나뉘며, 
        - "hardSkill" : 기술적 역량, 문제 해결 과정, 성과, 성능 개선, 아키텍처 설계 등을 묻는다.
        - "softSkill" : 협업, 커뮤니케이션, 리더십, 갈등 해결, 비즈니스 마인드 등을 묻는다.
      3. 최종 출력은 JSON 배열 형식으로 표현한다.
      ]

      [type: data | content:
      이력서 내용:
      "${request.resumeContent}"

      포트폴리오 내용:
      "${request.portfolioContent}"
      ]

      [type: rules | content:
      - 총 질문 개수: 4 ~ 8개
      - 각 질문의 구체적인 목적과 맥락이 드러나도록 작성한다. 
      - 질문은 지원자의 실제 경험(프로젝트, 기술 스택, 문제 해결 과정 등)을 토대로 만들어야 한다.
      - 평가 기준(evaluationPoint)은 50자 이내로 작성하고, 지원자가 어필할 수 있는 구체적인 기술적/소프트스킬 기준을 포함한다.
      - JSON 배열 안의 각 원소(=질문 객체)의 키는 다음과 같이 엄격히 지킨다:
        {
          "id": "Q1", 
          "question": "질문 내용", 
          "type": "hardSkill" or "softSkill", 
          "evaluationPoint": "평가 기준"
        }
      - id는 Q1, Q2, ... 등의 형태로 중복 없이 생성한다.
      ]

      [type: example | content:
      예시 출력(JSON):
      [
        {
          "id": "Q1",
          "question": "클린 아키텍처를 적용하여 코드 리뷰 시간을 단축한 방법을 설명해주세요.",
          "type": "hardSkill",
          "evaluationPoint": "클린 아키텍처 이해도, 코드 품질 개선 능력"
        },
        {
          "id": "Q2",
          "question": "팀 프로젝트에서 UI/UX 개선을 위해 디자이너와 협력한 경험을 공유해주세요.",
          "type": "softSkill",
          "evaluationPoint": "팀 협업 능력, 창의적 문제 해결 능력"
        }
      ]
      ]

      [type: output_format | content:
      - 위 규칙대로 구성한 'JSON 배열'만 출력한다.
      - 불필요한 문장이나 설명은 포함하지 않는다.
      ]
          ''',
        ),
      ],
      role: OpenAIChatMessageRole.system,
    );

    final startTime = DateTime.now();

    try {
      OpenAIChatCompletionModel completion = await OpenAI.instance.chat.create(
        model: 'o1',
        messages: [
          systemMessage,
        ],
      );

      debugPrint('Qna 토큰사용량 : ${completion.usage}');
      debugPrint('Qna 시간 : ${DateTime.now().difference(startTime).inSeconds}');
      debugPrint('Qna 결과 : ${completion.choices.first.message.content}');

      final response = completion.choices.first.message.content?.first.text;

      // 응답과 메시지에 대한 예외처리
      if (response == null) {
        throw Exception('GPT 응답이 없습니다.');
      }

      try {
        // JSON 파싱 및 결과 매핑
        final parsedResponse = jsonDecode(response);
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

        // Json 형태 예외처리
      } on FormatException catch (e, st) {
        debugPrint('JSON 포맷 오류 발생: $e\n$st');
        return Result.failure(
          Exception('응답을 JSON으로 파싱하지 못했습니다. 다시 시도해주세요.'),
        );
      }
    }
    // 그 외 모든 예외 처리
    catch (error, st) {
      debugPrint('CreateOpenAIResumeQuestionUseCase 오류: $error\n$st');
      return Result.failure(Exception(error.toString()));
    }
  }
}

    /// --------------------------------------------------------------
    /// [이전 로직 주석 처리]
    /// --------------------------------------------------------------

  //   try {
  //     // GPT 응답 대기
  //     final response = await OpenAI.instance.onChatCompletion(
  //       request: ChatCompleteText(
  //         messages: _createResumeChatMessage(request),
  //         maxToken: 1000,
  //         temperature: 0.5,
  //         user: FirebaseAuth.instance.currentUser!.uid,
  //         model: Gpt4OChatModel(),
  //       ),
  //     );

  //     // 응답과 메시지에 대한 예외처리
  //     if (response == null) {
  //       throw Exception('GPT 응답이 없습니다.');
  //     }
  //     if (response.choices.isEmpty ||
  //         response.choices[0].message == null ||
  //         response.choices[0].message!.content.isEmpty) {
  //       throw Exception('GPT 응답 메시지가 없습니다.');
  //     }

  //     // 예외 처리 조건을 거친 응답
  //     final rawContent = response.choices[0].message!.content;

  //     try {
  //       // JSON 파싱 및 결과 매핑
  //       final parsedResponse = jsonDecode(rawContent);
  //       final List<ResumeQnaEntity> qnaList = (parsedResponse as List)
  //           .map(
  //             (json) => ResumeQnaEntity(
  //               id: json['id'] ?? '',
  //               question: json['question'],
  //               questionType: json['type'] == 'hardSkill'
  //                   ? ResumeQuestionType.hardSkill
  //                   : ResumeQuestionType.softSkill,
  //               evaluationPoint: json['evaluationPoint'] ?? '',
  //             ),
  //           )
  //           .toList();

  //       // 디버깅용 프롬프트 출력
  //       debugPrint(
  //         const JsonEncoder.withIndent('').convert(
  //           qnaList.map((qna) {
  //             return {
  //               "id": qna.id,
  //               "question": qna.question,
  //               "type": qna.questionType == ResumeQuestionType.hardSkill
  //                   ? "hardSkill"
  //                   : "softSkill",
  //               "evaluationPoint": qna.evaluationPoint,
  //             };
  //           }).toList(),
  //         ),
  //       );

  //       return Result.success(qnaList);
  //     }

  //     // 실패 예외처리
  //     on FormatException catch (e) {
  //       debugPrint('JSON 포맷 오류: $e');

  //       return Result.failure(
  //         Exception('응답을 처리할 수 없습니다. 다시 시도해주세요.'),
  //       );
  //     }
  //   } catch (error) {
  //     return Result.failure(Exception(error.toString()));
  //   }
  // }

  // /// GPT 프롬프트 메시지 생성
  // List<Map<String, dynamic>> _createResumeChatMessage(GetResumeParam request) {
  //   final String promptContent = '''
  //     [type: system | content:
  //     당신은 개발자를 채용하는 회사의 채용 전문가(Interviewer)입니다. 
  //     지원자의 이력서와 포트폴리오 정보를 바탕으로, 
  //     지원자에게 질문을 작성하려고 합니다.

  //     목표:
  //     - 질문을 통해 지원자의 '기술 역량(hard skills)'과 '협업 능력, 문제 해결 능력(soft skills)'을 파악한다.
  //     - 작성된 질문은 지원자의 이력서 및 포트폴리오 내용에 기반하여, 구체적이고 실제 인터뷰 상황에서 도움이 되는 수준으로 구성한다.

  //     주의사항:
  //     1. 작성된 질문은 회사에서 현업 개발자를 뽑을 때 고려하는 요소(프로젝트 기여도, 문제 해결 능력, 코드 품질 등)에 집중한다.
  //     2. 질문은 하드스킬/소프트스킬 종류별로 나뉘며, 
  //       - "hardSkill" : 기술적 역량, 문제 해결 과정, 성과, 성능 개선, 아키텍처 설계 등을 묻는다.
  //       - "softSkill" : 협업, 커뮤니케이션, 리더십, 갈등 해결, 비즈니스 마인드 등을 묻는다.
  //     3. 최종 출력은 JSON 배열 형식으로 표현한다.
  //     ]

  //     [type: data | content:
  //     이력서 내용:
  //     "${request.resumeContent}"

  //     포트폴리오 내용:
  //     "${request.portfolioContent}"
  //     ]

  //     [type: rules | content:
  //     - 총 질문 개수: 4 ~ 8개
  //     - 각 질문의 구체적인 목적과 맥락이 드러나도록 작성한다. 
  //     - 질문은 지원자의 실제 경험(프로젝트, 기술 스택, 문제 해결 과정 등)을 토대로 만들어야 한다.
  //     - 평가 기준(evaluationPoint)은 50자 이내로 작성하고, 지원자가 어필할 수 있는 구체적인 기술적/소프트스킬 기준을 포함한다.
  //     - JSON 배열 안의 각 원소(=질문 객체)의 키는 다음과 같이 엄격히 지킨다:
  //       {
  //         "id": "Q1", 
  //         "question": "질문 내용", 
  //         "type": "hardSkill" or "softSkill", 
  //         "evaluationPoint": "평가 기준"
  //       }
  //     - id는 Q1, Q2, ... 등의 형태로 중복 없이 생성한다.
  //     ]

  //     [type: example | content:
  //     예시 출력(JSON):
  //     [
  //       {
  //         "id": "Q1",
  //         "question": "클린 아키텍처를 적용하여 코드 리뷰 시간을 단축한 방법을 설명해주세요.",
  //         "type": "hardSkill",
  //         "evaluationPoint": "클린 아키텍처 이해도, 코드 품질 개선 능력"
  //       },
  //       {
  //         "id": "Q2",
  //         "question": "팀 프로젝트에서 UI/UX 개선을 위해 디자이너와 협력한 경험을 공유해주세요.",
  //         "type": "softSkill",
  //         "evaluationPoint": "팀 협업 능력, 창의적 문제 해결 능력"
  //       }
  //     ]
  //     ]

  //     [type: output_format | content:
  //     - 위 규칙대로 구성한 'JSON 배열'만 출력한다.
  //     - 불필요한 문장이나 설명은 포함하지 않는다.
  //     ]
  // ''';

  //   return [
  //     {"role": "system", "content": promptContent},
  //   ];
  // }



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