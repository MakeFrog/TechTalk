import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dart_openai/dart_openai.dart';
import 'package:techtalk/app/environment/app_version.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/system/repositories/entities/youtube_gpt_model_type.enum.dart';
import 'package:techtalk/features/youtube/index.dart';

class GetRemainSummaryFromYoutubeContentUseCase
    extends BaseUseCase<(YoutubeVideoEntity, int), SummaryEntity> {
  @override
  Future<SummaryEntity> call((YoutubeVideoEntity, int) request) async {
    final videoEntity = request.$1;
    final chunkIndex = request.$2;

    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          '''
프로그래밍 관련 자막 데이터를 바탕으로 프로그래밍 개념을 직접 설명하듯이 요약하세요.

제목과 자막(caption) 데이터를 활용하여 아래 요구사항에 따라 세부적이고 체계적인 요약을 생성하세요.
현재 이 요청은 "원본 영상을 몇 개의 청크로 분할한 자막" 중 일부만 전송받은 상황이지만, 각 자막의 시간(`offset`)은 **원본 영상** 기준의 절대 시간을 유지합니다. 따라서 0초나 청크 시작 지점으로 offset을 다시 계산하지 마세요.

### 요구사항:
1. **핵심 주제 (`main_theme`) 작성**:
   - 빈 문자열 리턴
   
  
2. **세부 요약 목록 (`summaries`) 작성**:
   - 해당 내용을 섹션(챕터)별로 구분해 `title`과 `contents`를 작성하세요.
   - `contents`에는 프로그래밍 개념을 직접 설명하듯 자세히 서술하세요.
   - 시간 순서별(offset)로 중복 없이 나열하고, 각 섹션 시작 시간을 "HH:MM:SS" 또는 "HH:MM:SS.sss" 형식으로 적어주세요.
   - 다시 한 번 강조하지만, **offset은 원본 영상의 절대 시간**을 사용해야 합니다. (예: 0:10:06.320000)
    
---     
                        
### 입력 데이터 형식:
- **제목**: `${request.$1.title}`
- **자막 데이터**: `${request.$1.captions.map((e) => e.toMap()).toList()}`

### 응답 언어:
- 언어 코드에 해당되는 언어로 응답해야 됩니다.
- 언어 코드 : ${AppLocale.currentLocale.languageCode} 

### 응답 어체:
- 경어체 사용합니다.(존댓말) 

### 응답 형식:
모든 응답은 아래 JSON 구조를 따라야 합니다.
  
```json 
{ 
  "main_theme": "", // 빈 문자열 리턴
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

      log('나머지 Summary[${request.$2}] 토큰사용량 : ${completion.usage}'); // 응답 결과 출력
      log('나머지 Summary 시간 : ${DateTime.now().difference(startTime).inSeconds}'); // 응답 결과 출력
      log('나머지 Summary 결과랑이 : ${completion.choices.first.message.content?.first.text}'); // 응답 결과 출력
      // 🔹 전달된 captions 개수 및 첫/마지막 offset 확인
      log('🟢 나머지 Summary[${chunkIndex}] - 전달된 captions 개수: ${videoEntity.captions.length}');
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

      final targetEntity = SummaryEntity.fromJson(targetJson);

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
