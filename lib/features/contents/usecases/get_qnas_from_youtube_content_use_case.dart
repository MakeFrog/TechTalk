import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dart_openai/dart_openai.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/chat/repositories/entities/youtube_qna_entity.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_ai_qna_response.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_entity.dart';
import 'package:techtalk/features/contents/usecases/exception/youtube_ai_analyze_exception.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

class GetQnasFromYoutubeContentUseCase
    extends BaseUseCase<YoutubeVideoEntity, YoutubeAiQnaAndIdsResponse> {
  @override
  Future<YoutubeAiQnaAndIdsResponse> call(YoutubeVideoEntity request) async {
    final allSkills = techSetRepository.getSkills();
    // the system message that will be sent to the request.
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          '''
영상의 제목과 내용을 바탕으로 적합한 면접 질문과 모범답안을 작성하세요.
영상의 제목과 내용을 바탕으로 주어진 개발 스킬 id 리스트와 개발 직군 id 리스트를 기반으로 영상에 해당되는 id 값을 전달하세요.

### 요구사항:
1. **응답 유형 (`type`) 지정**:
   - **`notTech`**: 영상 내용이 프로그래밍과 관련이 없는 경우.
   - **`lackOfContent`**: 영상 내용이 충분히 기술적이지 않거나, 면접 질문을 만들기에 적합하지 않은 경우.
   - **`isValid`**: 영상 내용에서 기술 면접 질문을 생성할 수 있는 경우.

2. **질문(`qnas`) 작성**:
   - 최소 4개에서 최대 12개의 질문을 작성하세요.
   - 질문은 영상의 프로그래밍 개념과 직접적으로 연관되도록 구성하세요.
   - 각 질문에 명확하고 구체적인 모범 답안을 작성하세요.
   - 적절한 질문이 없을 경우 빈 배열(`[]`)을 반환하세요.

3. **개발 스킬 id 리스트(`skillIds`) 작성**:
4. **개발 직군 id 리스트(`jobGroupIds`) 작성**:
   - 영상의 내용과 관련된 스킬, 직군 id를 주어진 리스트에서 찾아 각각 반환하세요.
   - 꼭 주어진 리스트에 있는 id들만 반환해야 됩니다. 
   - 해당되는 id가 없으면 빈 배열(`[]`)을 반환하세요.
   - 관련되어 있는 id를 최대한 많이 반환하는것이 중요합니다.

---

### 입력 데이터 형식:
- **제목**: `${request.title}`  
- **내용**: `${request.script}`
- **개발 스킬 id 리스트**: `${allSkills.map((e) => e.id).toList()}`
- **개발 직군 id 리스트**: `${JobGroup.values.map((e) => e.id).toList()}`

### 응답 언어:
- 언어 코드에 해당되는 언어로 응답하세요.
- 언어 코드: `${AppLocale.currentLocale.languageCode}`

### 응답 형식:
아래 JSON 구조를 따르세요:
```json
{
  "type": "notTech | lackOfContent | isValid",
  "qnas": [
    { 
      "question": "면접 질문",
      "answer": "모범 답안"
    }
  ],
  "skillIds": ["skillId1", "skillId2", ...],
  "jobGroupIds": ["jobGroupId1", "jobGroupId2", ...]
}
          ''',
        ),
      ],
      role: OpenAIChatMessageRole.system,
    );

    final startTime = DateTime.now();

    try {
      OpenAIChatCompletionModel completion = await OpenAI.instance.chat.create(
        model: "gpt-4o",
        messages: [
          systemMessage,
        ],
        responseFormat: {"type": "json_object"},
        temperature: 0.8,
      );

      log('Qna 토큰사용량 : ${completion.usage}'); // 응답 결과 출력
      log('Qna 시간 : ${DateTime.now().difference(startTime).inSeconds}'); // 응답 결과 출력
      log('Qna 결과랑이 : ${completion.choices.first.message.content?.first.text}'); // 응답 결과 출력
      log('Qna 결과 : ${completion.choices.first.message.content}'); // 응답 결과 출력

      final response = completion.choices.first.message.content?.first.text;

      if (response == null) {
        throw const YtUnexceptedGptException();
      }

      final targetJson = jsonDecode(response);

      final targetEntity = YoutubeAiQnaAndIdsResponse.fromJson(targetJson);
      print('이찌방 qna 성공 : ${targetEntity}');
      return targetEntity;
    } on RequestFailedException catch (e) {
      log('GetSummaryFromYoutubeContentUseCase : $e');
      throw const YtUnexceptedGptException();
    } catch (e) {
      if (e is TimeoutException) {
        log('GetSummaryFromYoutubeContentUseCase / TimeoutException / $e');
        throw const YtTimeoutException();
      } else if (e is FormatException) {
        log('GetSummaryFromYoutubeContentUseCase / FormatException :$e');
        throw const YtJsonFormatException();
      }

      log('GetSummaryFromYoutubeContentUseCase : 그 외 오류 :$e');

      throw const YtUnknownException();
    }
  }
}
