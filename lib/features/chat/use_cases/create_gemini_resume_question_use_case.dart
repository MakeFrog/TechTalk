// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:pdf_gemini/pdf_gemini.dart';
// import 'package:techtalk/app/environment/flavor.dart';
// import 'package:techtalk/core/index.dart';
// import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';
// import 'package:techtalk/features/chat/repositories/enums/resume_question_type.enum.dart';

// typedef GetResumeParam = ({
//   String? resumePath,
//   String? portfolioPath,
// });

// class CreateGeminiResumeQuestionUseCase {
//   Future<Result<List<ResumeQnaEntity>>> call(GetResumeParam request) async {
//     final genaiService = GenaiClient(geminiApiKey: Flavor.env.geminiApiKey);

//     const prompt = '''
// 당신은 숙련된 개발자를 채용하는 면접관(ROLE)입니다. 
// 아래 문서를 꼼꼼히 검토한 뒤, 지원자의 역량과 잠재력을 파악할 수 있는 면접 질문을 4~6개 작성해 주세요.

// (1) 질문은 한두 문장 내로 간결하게 작성해주세요.
// (2) 아래 내용을 참고하여 종합적으로 평가할 수 있는 내용으로 구성해주세요.
//   - 기술 스택
//   - 문제해결 능력
//   - 학습 가능성
//   - 프로젝트 혹은 작업물의 기여도와 임팩트
//   - 기술적 난이도와 문제해결 능력
//   - 코드 품질과 유지보수 가능성
//   - 협업 및 커뮤니케이션 방식
//   - 확장 가능성 있는 지식/경험
// (3) 각 질문마다 "evaluationPoint"를 적어주세요.

// 출력 시 순수 JSON 배열 형식으로만 작성하고, 다음 예시 형식을 준수해 주세요. 
// 백틱(```) 등의 추가 구분자는 넣지 말아 주세요:

// [
//   {
//     "id": "Q1",
//     "question": "이력서에 기재된 프로젝트 중 가장 큰 어려움을 어떻게 해결했는지 설명해 주세요.",
//     "type": "hardSkill",
//     "evaluationPoint": "지원자의 문제해결 과정, 협업 능력, 기술 깊이"
//   }
// ]
// ''';

//     try {
//       final futures = <Future<String>>[];

//       /// 이력서
//       final resumePath = request.resumePath;
//       if (resumePath != null && resumePath.isNotEmpty) {
//         final file = File(resumePath);
//         if (file.existsSync()) {
//           final pdfBytes = await file.readAsBytes();

//           futures.add(
//             genaiService
//                 .promptDocument(
//                   'resume_pdf_${DateTime.now().millisecondsSinceEpoch}',
//                   'pdf',
//                   pdfBytes,
//                   prompt,
//                 )
//                 .then((res) => res.text),
//           );
//         }
//       }

//       /// 포트폴리오
//       final portfolioPath = request.portfolioPath;
//       if (portfolioPath != null && portfolioPath.isNotEmpty) {
//         final file = File(portfolioPath);
//         if (file.existsSync()) {
//           final pdfBytes = await file.readAsBytes();

//           futures.add(
//             genaiService
//                 .promptDocument(
//                   'portfolio_pdf_${DateTime.now().millisecondsSinceEpoch}',
//                   'pdf',
//                   pdfBytes,
//                   prompt,
//                 )
//                 .then((res) => res.text),
//           );
//         }
//       }

//       // 모두 없으면 실패 처리
//       if (futures.isEmpty) {
//         return Result.failure(Exception("이력서/포트폴리오 파일이 없습니다."));
//       }

//       // 병렬로 요청
//       final results = await Future.wait(futures);

//       // 각각 파싱한 뒤, 하나의 리스트로 merge
//       final combinedQnas = <ResumeQnaEntity>[];
//       for (final rawJson in results) {
//         final qnas = _parseGeminiJson(rawJson);
//         combinedQnas.addAll(qnas);
//       }

//       // QnA가 단 하나도 없으면 실패
//       if (combinedQnas.isEmpty) {
//         return Result.failure(Exception("이력서/포트폴리오 면접 질문이 생성되지 않았습니다."));
//       }

//       return Result.success(combinedQnas);
//     } catch (e, s) {
//       debugPrint('Gemini 면접 질문 생성 중 오류: $e');
//       debugPrint('$s');
//       return Result.failure(Exception(e));
//     }
//   }

//   /// Gemini 응답(JSON 문자열) → List<ResumeQnaEntity>
//   List<ResumeQnaEntity> _parseGeminiJson(String rawJson) {
//     try {
//       // 백틱/마크다운 제거
//       String sanitized = rawJson.trim();
//       sanitized = sanitized.replaceAll(RegExp(r'```(\w+)?'), '');
//       sanitized = sanitized.replaceAll('```', '');

//       // JSON 파싱
//       final decoded = jsonDecode(sanitized);
//       if (decoded is! List) {
//         return [];
//       }

//       // Map → ResumeQnaEntity 변환
//       return decoded
//           .map((item) {
//             final questionTypeStr = item["type"] as String? ?? "";
//             final resumeQuestionType = (questionTypeStr == "hardSkill")
//                 ? ResumeQuestionType.hardSkill
//                 : ResumeQuestionType.softSkill;

//             return ResumeQnaEntity(
//               id: item["id"] ?? "",
//               question: item["question"] ?? "",
//               questionType: resumeQuestionType,
//               evaluationPoint: item["evaluationPoint"] ?? "",
//             );
//           })
//           .cast<ResumeQnaEntity>()
//           .toList();
//     } catch (e, s) {
//       debugPrint('JSON 파싱 실패: $e');
//       debugPrint('$s');
//       return [];
//     }
//   }
// }
