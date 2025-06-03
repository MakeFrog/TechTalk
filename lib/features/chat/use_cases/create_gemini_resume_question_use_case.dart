import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:techtalk/app/environment/flavor.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/resume_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/resume_question_type.enum.dart';

typedef GetResumeParam = ({
  String resumeContent,
  String portfolioContent,
});

final safetySettings = [
  SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
  SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
];

final gemini = GenerativeModel(
  model: 'gemini-2.0-flash',
  apiKey: Flavor.env.geminiApiKey,
  safetySettings: safetySettings,
);

class CreateGeminiResumeQuestionUseCase {
  Future<Result<List<ResumeQnaEntity>>> call(GetResumeParam request) async {
    final prompt = '''
[Contents]
- 이력서 내용: "${request.resumeContent}"
- 포트폴리오 내용: "${request.portfolioContent}"

[Persona]
- 당신은 경력 많은 "AI 면접관"입니다.
- 지원자의 이력서/포트폴리오에는 주로 Flutter, 협업 경험, 프로젝트 성과, 문제 해결 과정 등이 담겨 있습니다.

[Task]
- 지원자의 전문성을 검증할 구체적·심층적 질문 4~8개를 만들어 주세요.
- 질문은 모두 JSON 배열 형태로 출력하며, "id", "question", "type", "evaluationPoint" 필드만 포함하세요.
- "type"은 "hardSkill" 또는 "softSkill" 중 하나만 가능합니다.

[Context]
- 각 질문은 최소 50자 ~ 최대 150자 이내의 길이로 작성하세요 (띄어쓰기 포함).
- 기술 스택, 협업 경험, 프로젝트 성과, 문제 해결 과정 등을 충분히 반영해주세요.
  - 단, 너무 장황하지 않도록 핵심 요점을 질문해 주세요.
  - "문제 정의 → 원인 분석 → 해결책 도출 → 결과" 등 단계별로 구체적 역량을 평가하는 질문을 만드세요.
  - "팀 내 역할, 갈등 해결, 커뮤니케이션" 등 협업 측면도 묻되, 한 질문 안에서 군더더기를 줄여주세요.

[Rules for Output]
1. 절대 백틱(```)이나 마크다운을 사용하지 말 것.
2. JSON 배열만 출력 (여는/닫는 대괄호 + 객체들).
3. 각 객체는 다음 예시처럼 구성 (나머지 불필요한 필드/문장은 쓰지 말 것):
      [
        {
          "id": "Q1",
          "question": "테크톡에서 다국어 음성 인터뷰 기능을 구현할 때 동시 요청이나 데이터 일관성 문제는 어떻게 해결했는지 구체적으로 설명해주세요.",
          "type": "hardSkill",
          "evaluationPoint": "동시성 처리 능력, 데이터 무결성 보장 역량"
        },
        {
          "id": "Q2",
          "question": "프로젝트 전반에서 코드 리뷰 문화가 팀 생산성에 미친 영향을 구체적으로 말씀해주시고, 본인이 주도한 개선점이 있었다면 소개해주세요.",
          "type": "softSkill",
          "evaluationPoint": "팀 리뷰 문화 기여도, 소통 리더십"
        }
      ]
''';

    try {
      final content = [Content.text(prompt)];
      final response = await gemini.generateContent(content);
      debugPrint('GEMINI 프롬프트 결과 : ${response.text}');
      debugPrint(
          '프롬프트에 사용된 토큰 수 : ${response.usageMetadata?.promptTokenCount}');
      debugPrint(
          '모델이 생성한 결과물에서 사용된 토큰 수 : ${response.usageMetadata?.candidatesTokenCount}');
      debugPrint(
          '이 호출에 사용된 총 토큰 수 : ${response.usageMetadata?.totalTokenCount}');

      // 응답 텍스트 저장
      final rawText = response.text ?? '';
      if (rawText.isEmpty) {
        return Result.failure(Exception("GEMINI 응답이 비어있습니다."));
      }

      // 백틱, 마크다운 제거
      final sanitized = rawText
          .replaceAll(RegExp(r'```(\w+)?'), '')
          .replaceAll('```', '')
          .trim();

      // JSON 파싱
      final decoded = jsonDecode(sanitized);
      if (decoded is! List) {
        return Result.failure(Exception("JSON 배열 형태의 응답이 아닙니다."));
      }

      // ResumeQnaEntity 리스트로 변환
      final qnaList = <ResumeQnaEntity>[];
      for (final item in decoded) {
        final id = item['id'] ?? '';
        final question = item['question'] ?? '';
        final type = item['type'] ?? '';
        final evaluationPoint = item['evaluationPoint'] ?? '';

        final questionType = (type == 'hardSkill')
            ? ResumeQuestionType.hardSkill
            : ResumeQuestionType.softSkill;

        qnaList.add(
          ResumeQnaEntity(
            id: id,
            question: question,
            questionType: questionType,
            evaluationPoint: evaluationPoint,
          ),
        );
      }

      if (qnaList.isEmpty) {
        return Result.failure(Exception("면접 질문이 생성되지 않았습니다."));
      }

      return Result.success(qnaList);
    } catch (e, s) {
      debugPrint('Gemini 면접 질문 생성 중 오류: $e');
      debugPrint('$s');
      return Result.failure(Exception(e));
    }
  }
}
