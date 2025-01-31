import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dart_openai/dart_openai.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/youtube/index.dart';

class GetSummaryFromYoutubeContentUseCase
    extends BaseUseCase<YoutubeVideoEntity, YoutubeAiSummaryResponse> {
  @override
  Future<YoutubeAiSummaryResponse> call(YoutubeVideoEntity request) async {
    // - 주제를 설명할 때 '영상'이라는 단어를 사용하지 마세요.

    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          '''
프로그래밍 관련 자막 데이터를 바탕으로 프로그래밍 개념을 직접 설명하듯이 요약하세요.

제목과 자막(caption) 데이터를 활용하여 아래 요구사항에 따라 세부적이고 체계적인 요약을 생성하세요.

### 요구사항:
1. **응답 유형 (`type`) 지정**:
   - **`notTech`**: 영상 내용이 프로그래밍과 관련이 없는 경우. 
   - **`lackOfContent`**: 정보가 부족해 요약이 어렵거나 프로그래밍 관련 영상이지만 프로그래밍 개념 설명 영상이 아닌 경우. ex) 개발자 인터뷰, 브이로그
   - **`isValid`**: 영상 내용 요약이 성공적으로 이루어진 경우.
   - `isValid` 타입이 아니면 `main_theme`과 `summaries`를 빈문자열, 빈배열을 반환합니다.

2. **핵심 주제 (`main_theme`) 작성**:
   - 해당 내용에서 다루는 핵심 프로그래밍 개념을 2~4문장으로 요약하세요.
   - 직접 개념을 설명하듯 작성하시고, '영상'이라는 단어는 절대 사용하지 마세요.
   
  
3. **세부 요약 목록 (`summaries`) 작성**:
   - 해당 내용을 섹션(챕터)별로 구분해 `title`과 `contents`를 작성하세요.
   - `contents`에는 프로그래밍 개념을 직접 설명하듯 자세히 서술하세요.
   - 시간 순서별(offset)로 중복 없이 나열하고, 각 섹션 시작 시간을 "HH:MM:SS" 또는 "HH:MM:SS.sss" 형식으로 적어주세요.
    
---   
            
### 입력 데이터 형식:
- **제목**: `${request.title}`
- **자막 데이터**: `${request.captions.map((e) => e.toMap()).toList()}`

### 응답 언어:
- 언어 코드에 해당되는 언어로 응답해야 됩니다.
- 언어 코드 : ${AppLocale.currentLocale.languageCode} 

### 응답 어체:
- 경어체 사용합니다.(존댓말)

### 응답 형식:
모든 응답은 아래 JSON 구조를 따라야 합니다.
  
```json 
{
  "type": "notTech | lackOfContent | isValid", // 필수
  "main_theme": "영상의 핵심 주제", // 필수
  "summaries": [ // 필수
    {
      "title": "요약 제목", // 선택 (빈 문자열 가능)
      "contents": ["요약 내용1", "요약 내용2", "요약 내용3", "요약 내용4", ...], // 선택 (빈 배열 가능)
      "offset": "0:10:55.839000" // 필수
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
        model: "o1",
        messages: [
          systemMessage,
        ],
        responseFormat: {"type": "json_object"},
      );

      log('Summary 토큰사용량 : ${completion.usage}'); // 응답 결과 출력
      log('Summary 시간 : ${DateTime.now().difference(startTime).inSeconds}'); // 응답 결과 출력
      log('Summary 결과랑이 : ${completion.choices.first.message.content?.first.text}'); // 응답 결과 출력

      final response = completion.choices.first.message.content?.first.text;

      if (response == null) {
        throw const YtUnexceptedGptException();
      }

      final targetJson = jsonDecode(response);

      final targetEntity = YoutubeAiSummaryResponse.fromJson(targetJson);

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
