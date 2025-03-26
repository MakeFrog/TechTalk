import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dart_openai/dart_openai.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/proficiency_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/interview_level.enum.dart';
import 'package:techtalk/features/interview/use_case/exception/ai_creation_failed_exception.dart';
import 'package:techtalk/features/interview/use_case/param/start_interview_flow_use_case_param.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';

final class CreateProficiencyInterviewQnaUseCase extends BaseUseCase<
    ProficiencyInterviewFlowParam, List<ProficiencyQnaEntity>> {
  @override
  FutureOr<List<ProficiencyQnaEntity>> call(
      ProficiencyInterviewFlowParam req) async {
    final techSets = await req.topicSelectionCompleter.future;
    final List<SkillEntity> skills = [];
    final List<JobGroupEntity> jobGroups = [];
    final int questionCount = await req.questionCountCompleter.future ?? 4;
    final InterviewLevel level =
        await req.levelSelectionCompleter.future ?? InterviewLevel.intermediate;

    techSets?.forEach(
      (e) {
        switch (e) {
          case SkillEntity():
            skills.add(e);
          case JobGroupEntity():
            jobGroups.add(e);
        }
      },
    );

    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          '''
IT 회사의 면접관입니다. 선택된 개발 스킬과 직군에 대한 기술 면접 질문을 생성해주세요.

### 목표
- 선택된 개발 스킬과 직군에 대한 실무 중심의 기술 면접 질문 생성  
- 난이도가 높아짐에 따라 더 깊은 프로그래밍 개념 이해가 필요한 심층 질문 제시
- 난이도가 높이짐에 따라 심화 배경 지식을 요구하는 심층 질문 제시

### 요구사항  
1. **질문 구성**  
   - 요청된 질문 개수만큼 생성
   - 선택된 스킬과 직군별로 균형 잡힌 질문 분포
   - 각 스킬/직군별 최소 1개 이상의 질문 포함
   - 예시 코드 작성을 답변으로 요구하는 질문 지양
   - '심도 있게', '심화적인' '기본'등 질문의 난이도를 직접적으로 표현하는 단어 사용 지양

2. **난이도별 질문 특성**
   - 상: 선택된 스킬/직군의 심화된 기술 개념과 원리
   - 중: 선택된 스킬/직군의 핵심 기술 개념과 원리
   - 하: 선택된 스킬/직군의 기초 기술 개념과 원리

3. **답안 구성**
   - 실제 개발자가 면접에서 답변하는 것처럼 자연스럽게 작성
   - 명확한 모범 답안 작성
   - 단계별 설명 (필요한 경우)
   
  
### 주의사항
- 실제 기술 면접에서 사용할 수 있는 수준의 질문 작성
- 선택된 스킬/직군 외의 내용은 제외
- 모든 답안은 검증 가능한 기술적 사실에 기반
- 질문과 답안은 지정된 언어로 작성

### 입력 데이터
- 선택된 스킬: `${skills.map((e) => e.toMap()).toList()}`
- 선택된 직군: `${jobGroups.map((e) => e.toMap()).toList()}`
- 선택된 레벨: `${level.label}`
- 선택된 질문 개수: `${questionCount}`
- 응답 언어: `${AppLocale.currentLocale.languageCode}`

### 응답 형식
```json
{
  "qnas": [
    {
      "question": "면접 질문",
      "techSetId": "react", // or "server-developer" (직군 또는 스킬 id)
      "answer": [
        "모범 답안1",
        "모범 답안2"
      ]
    }
  ]
}
```
          ''',
        ),
      ],
      role: OpenAIChatMessageRole.system,
    );

    final startTime = DateTime.now();

    try {
      OpenAIChatCompletionModel completion = await OpenAI.instance.chat.create(
        model: 'o3-mini',
        messages: [
          systemMessage,
        ],
        temperature: 1.0,
        responseFormat: {"type": "json_object"},
      );

      log('Qna 토큰사용량 : ${completion.usage}'); // 응답 결과 출력
      log('Qna 시간 : ${DateTime.now().difference(startTime).inSeconds}'); // 응답 결과 출력
      log('Qna 결과 : ${completion.choices.first.message.content}'); // 응답 결과 출력

      final response = completion.choices.first.message.content?.first.text;

      if (response == null) {
        throw const AiUnExpectedException();
      }

      final targetJson = jsonDecode(response);

      final qnasFields = (targetJson["qnas"] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      final result = qnasFields
          .map((e) => ProficiencyQnaEntity.fromGptResponse(json: e))
          .toList();
      return result;
    } on RequestFailedException catch (e) {
      log('GetSummaryFromYoutubeContentUseCase / RequestFailedException / $e');
      if (e.message.contains('Please reduce the length of the messages')) {
        throw const AiTimeoutException();
      }
      log('GetSummaryFromYoutubeContentUseCase : $e');
      throw const AiUnExpectedException();
    } catch (e) {
      if (e is TimeoutException) {
        log('GetSummaryFromYoutubeContentUseCase / TimeoutException / $e');
        throw const AiTimeoutException();
      } else if (e is FormatException) {
        log('GetSummaryFromYoutubeContentUseCase / FormatException :$e');
        throw const AiJsonFormatException();
      }

      log('GetSummaryFromYoutubeContentUseCase : 그 외 오류 :$e');

      throw const AiUnExpectedException();
    }
  }
}
