import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pdf_gemini/pdf_gemini.dart';
import 'package:techtalk/app/environment/flavor.dart';
import 'package:techtalk/core/index.dart';

typedef GetGeminiParam = ({
  String? resumePath,
  String? portfolioPath,
});

/// 이 유즈케이스는 이력서/포트폴리오 PDF를 분석한 결과를
/// 아래 JSON 배열 형태로 반환합니다:
/// [
///   { "type": "이력서", "content": "..." },
///   { "type": "포트폴리오", "content": "..." }
/// ]
class SummarizeGeminiResumeUseCase {
  Future<Result<List<Map<String, String>>>> call(GetGeminiParam request) async {
    final genaiService = GenaiClient(geminiApiKey: Flavor.env.geminiApiKey);

    // TODO; Enum으로 변경하기 (yundal)
    const String resume = '이력서';
    const String portfolio = '포트폴리오';

    // 공통 프롬프트
    String prompt(String type) {
      return '''
당신은 개발자 채용을 위해 고용된 PDF 분석전문가(ROLE)입니다.
1) 문서(이력서 또는 포트폴리오)를 면밀히 분석한 뒤, **JSON 배열**로만 최종 결과를 출력해 주세요.  
2) 백틱(```)이나 코드 블록, 여타 설명 문구는 일절 넣지 말아주세요. 
3) "content" 필드 안에는 아래 항목을 작성해주세요.
- 오직 텍스트로만 구성해주세요.
- 개인/연락 정보 : 이름을 제외한 모든 연락처는 일절 기록 금지
- 자기소개/경력 요약 : 문서에 언급된 자기소개, 핵심 경력, 성장 스토리 등
- 기술 스택 : 언어, 프레임워크, 라이브러리, DB, 기타 개발 툴 등 (문서에 실제로 나오지 않은 기술은 기재 금지)
- 프로젝트 경험 : 프로젝트명, 기간, 팀 규모, 사용 기술, 역할/기여도, 난이도, 결과/성과, 어려웠던 점, 해결 과정 등 (문서에 있으면 기재)
- 협업/소프트스킬 : 협업 툴(Jira, Notion 등), 커뮤니케이션 방식, 문서화, 팀 프로젝트 논의 (문서에 있으면 작성, 없으면 건너뜀)
- 교육/수상/기타 : 학력, 수상 내역, 대외활동, 자격증, 동아리 활동 (없으면 건너뜀)

  {
    "type": "$type",
    "content": "content에 넣어줄 내용 목록입니다. 상단에 언급된 준수해야 할 내용을 조건에 맞게 작성해주세요."
  },

  주의사항:
1) "content"에는 오직 텍스트로만 구성해 주세요.
2) PDF에 없는 정보를 추측하거나 임의로 생성하지 말고, 실제 문서에 존재하는 내용만 반영해 주세요.
3) 최종 출력은 오직 위 예시 JSON 배열 형태로만 작성해 주세요.
''';
    }

    try {
      final futures = <Future<String>>[];

      // 이력서 처리
      final resumePath = request.resumePath;
      if (resumePath != null && resumePath.isNotEmpty) {
        final file = File(resumePath);
        if (file.existsSync()) {
          final pdfBytes = await file.readAsBytes();
          futures.add(
            genaiService
                .promptDocument(
                  'resume_pdf_${DateTime.now().millisecondsSinceEpoch}',
                  'pdf',
                  pdfBytes,
                  prompt(resume),
                )
                .then((res) => res.text),
          );
        }
      }

      // 포트폴리오 처리
      final portfolioPath = request.portfolioPath;
      if (portfolioPath != null && portfolioPath.isNotEmpty) {
        final file = File(portfolioPath);
        if (file.existsSync()) {
          final pdfBytes = await file.readAsBytes();
          futures.add(
            genaiService
                .promptDocument(
                  'portfolio_pdf_${DateTime.now().millisecondsSinceEpoch}',
                  'pdf',
                  pdfBytes,
                  prompt(portfolio),
                )
                .then((res) => res.text),
          );
        }
      }

      // 둘 다 없으면 실패
      if (futures.isEmpty) {
        return Result.failure(Exception("이력서/포트폴리오 파일이 없습니다."));
      }

      // 비동기로 GPT 응답 대기
      final results = await Future.wait(futures);

      // "이력서" / "포트폴리오" 각각 content를 저장할 임시 변수를 준비
      String resumeContent = "";
      String portfolioContent = "";

      // 각 GPT 응답을 파싱
      for (final rawJson in results) {
        // 백틱 제거 등 전처리
        String sanitized = rawJson.trim();
        sanitized = sanitized.replaceAll(RegExp(r'```(\w+)?'), '');
        sanitized = sanitized.replaceAll('```', '');

        // JSON 배열 파싱
        final decoded = jsonDecode(sanitized);
        if (decoded is List) {
          // 배열 내부에 여러 객체가 있을 수 있으므로 순회
          for (final item in decoded) {
            if (item is Map<String, dynamic>) {
              final type = item["type"] ?? "";
              final content = item["content"] ?? "";

              if (type.contains("이력서")) {
                resumeContent = content;
              } else if (type.contains("포트폴리오")) {
                portfolioContent = content;
              }
            }
          }
        }
      }

      // 최종적으로 항상 2개의 객체를 가진 배열을 생성
      final finalArray = <Map<String, String>>[
        {
          "type": "이력서",
          "content": resumeContent,
        },
        {
          "type": "포트폴리오",
          "content": portfolioContent,
        },
      ];

      // 만약 둘 다 빈 문자열이라면, 실제로 아무 결과도 없는 것이므로 오류 처리 가능
      // 하지만 여기서는 요청사항대로 그냥 반환
      if (resumeContent.isEmpty && portfolioContent.isEmpty) {
        debugPrint("이력서와 포트폴리오 모두 빈 내용입니다.");
      }

      // 디버깅용 로그: Pretty JSON 출력
      debugPrint("===== SummarizeGeminiResumeUseCase 결과 =====");
      debugPrint(
        const JsonEncoder.withIndent('  ').convert(finalArray),
      );

      // 반환: Result.success([...])
      return Result.success(finalArray);
    } catch (e, s) {
      debugPrint('Gemini 면접 질문 생성 중 오류: $e');
      debugPrint('$s');
      return Result.failure(Exception(e));
    }
  }
}
