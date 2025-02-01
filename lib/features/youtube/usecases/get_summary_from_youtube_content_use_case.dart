import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dart_openai/dart_openai.dart';
import 'package:techtalk/app/environment/app_version.dart';
import 'package:techtalk/app/localization/app_locale.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/system/repositories/entities/youtube_gpt_model_type.enum.dart';
import 'package:techtalk/features/youtube/index.dart';

class GetSummaryFromYoutubeContentUseCase
    extends BaseUseCase<(YoutubeVideoEntity, bool), SummaryEntity> {
  @override
  Future<SummaryEntity> call((YoutubeVideoEntity, bool) request) async {
    // - 주제를 설명할 때 '영상'이라는 단어를 사용하지 마세요.
    final videoEntity = request.$1;
    final hasBeenDivided = request.$2;

    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          '''
프로그래밍 관련 자막 데이터를 바탕으로 프로그래밍 개념을 직접 설명하듯이 요약하세요.

제목과 자막(caption) 데이터를 활용하여 아래 요구사항에 따라 세부적이고 체계적인 요약을 생성하세요.
${hasBeenDivided ? '주의: 이 자막은 **전체 영상 중 일부(분할된 구간)**일 뿐, 전체가 아닙니다.' : ''}

### 요구사항:
1. **핵심 주제 (`main_theme`) 작성**:
   - 해당 내용에서 다루는 핵심 프로그래밍 개념을 2~4문장으로 요약하세요.
   - 직접 개념을 설명하듯 작성하시고, '영상'이라는 단어는 절대 사용하지 마세요.
   
  
2. **세부 요약 목록 (`summaries`) 작성**:
   - 해당 내용을 섹션(챕터)별로 구분해 `title`과 `contents`를 작성하세요.
   - `contents`에는 프로그래밍 개념을 직접 설명하듯 자세히 서술하세요.
   - 시간 순서별(offset)로 중복 없이 나열하고, 각 섹션 시작 시간을 "HH:MM:SS" 또는 "HH:MM:SS.sss" 형식으로 적어주세요. 
   - ${hasBeenDivided ? '**영상이 분할되어 있기 때문에**, 오직 이 구간에 해당하는 offset만 요약 대상입니다. 다음 구간(이후 청크)은 존재할 수 있으나 여기서는 다루지 않습니다' : ''}.
    
---     
              
### 입력 데이터 형식:
- **제목**: `${videoEntity.title}`  
- **자막 데이터**: `${videoEntity.captions.map((e) => e.toMap()).toList()}`
- **영상 설명**: `${videoEntity}`    

### 응답 언어:
- 항상 **언어 코드**에 해당되는 언어로 응답해야 됩니다.
- 언어 코드 : ${AppLocale.currentLocale.languageCode} 

### 응답 어체:
- 경어체 사용합니다.(존댓말)

### 응답 형식:
모든 응답은 아래 JSON 구조를 따라야 합니다.
    
```json 
{
  "main_theme": "영상의 핵심 주제", // 필수
  "summaries": [ // 필수
    {
      "title": "요약 제목", // 필수 
      "contents": ["요약 내용1", "요약 내용2", "요약 내용3", "요약 내용4", ...], // 필수
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

      log('Summary 토큰사용량 : ${completion.usage}'); // 응답 결과 출력
      log('Summary 시간 : ${DateTime.now().difference(startTime).inSeconds}'); // 응답 결과 출력
      log('Summary 결과랑이 : ${completion.choices.first.message.content?.first.text}'); // 응답 결과 출력
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
