import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dart_openai/dart_openai.dart';
import 'package:techtalk/app/environment/app_version.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/system/repositories/entities/youtube_gpt_model_type.enum.dart';
import 'package:techtalk/features/youtube/index.dart';
import 'package:techtalk/features/youtube/repositories/entities/youtube_ai_main_theme_response.dart';

class GetMainSummaryThemeUseCase
    extends BaseUseCase<YoutubeVideoEntity, YoutubeAiMainThemeResponse> {
  @override
  Future<YoutubeAiMainThemeResponse> call(YoutubeVideoEntity request) async {
    // - 주제를 설명할 때 '영상'이라는 단어를 사용하지 마세요.
    final videoEntity = request;

    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          '''
프로그래밍 관련 영상 자막 데이터를 바탕으로 프로그래밍 개념을 직접 설명하듯이 핵심 내용을 요약하세요.


### 요구사항:
1. **응답 유형 (`type`) 지정**:
   - **`notTech`**: 영상 내용이 프로그래밍과 관련이 없는 경우.
   - **`isValid`**: 영상 내용에서 기술 면접 질문을 생성할 수 있는 경우.

2. **핵심 주제 (`main_theme`) 작성**:
   - 해당 내용에서 다루는 핵심 프로그래밍 개념을 2~3문장으로 요약하세요.
   - 직접 개념을 설명하듯 작성하신고, '영상' 라는 단어는 절대 사용하지 마세요.
    
---     
                                
### 입력 데이터 형식:
- **제목**: `${videoEntity.title}`  
- **자막 데이터**: `${videoEntity.script}`  

### 응답 언어:
- 항상 **언어 코드**에 해당되는 언어로 응답해야 됩니다.
- 언어 코드 : ${AppLocale.currentLocale.languageCode} 

### 응답 어체:
- 경어체 사용합니다.(존댓말)

### 응답 형식:
모든 응답은 아래 JSON 구조를 따라야 합니다.
    
```json 
{
  "type": "notTech | isValid", // 필수
  "main_theme": "영상의 핵심 주제", // 필수
}
  ```
          ''',
        ),
      ],
      role: OpenAIChatMessageRole.system,
    );

    final startTime = DateTime.now();

    final model = AppVersion().to?.youtubeGptModel ?? YoutubeGptModelType.gpt4o;
    try {
      OpenAIChatCompletionModel completion = await OpenAI.instance.chat.create(
        model: model.id,
        messages: [
          systemMessage,
        ],
        temperature: model.isGpt4o ? 1.0 : null,
        responseFormat: {"type": "json_object"},
      );

      log('핵심 주제 요약 토큰사용량 : ${completion.usage}'); // 응답 결과 출력
      log('핵심 주제 요약 시간 : ${DateTime.now().difference(startTime).inSeconds}'); // 응답 결과 출력
      log('핵심 주제 요약 결과랑이 : ${completion.choices.first.message.content?.first.text}'); // 응답 결과 출력
      // 🔹 전달된 captions 개수 및 첫/마지막 offset 확인
      log('🟢 앞쪽 Summary[${0}] - 전달된 captions 개수: ${videoEntity.captions.length}');
      if (videoEntity.captions.isNotEmpty) {
        log('   └ 시작 offset: ${videoEntity.captions.first.end}');
        log('   └ 끝 offset  : ${videoEntity.captions.last.end}');
      }

      // 🔹 첫 5개 자막만 샘플 출력 (너무 많으면 로그 과부하 방지)
      for (int i = 0; i < videoEntity.captions.length && i < 5; i++) {
        final caption = videoEntity.captions[i];
        log('   [$i] ${caption.end} → "${caption.text}"');
      }

      final response = completion.choices.first.message.content?.first.text;

      if (response == null) {
        throw const YtUnexceptedGptException();
      }

      final targetJson = jsonDecode(response);

      final targetEntity = YoutubeAiMainThemeResponse.fromJson(targetJson);

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
