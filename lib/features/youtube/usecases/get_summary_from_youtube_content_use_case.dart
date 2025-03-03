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
    extends BaseUseCase<(YoutubeVideoEntity, bool), List<ParagraphEntity>> {
  @override
  Future<List<ParagraphEntity>> call((YoutubeVideoEntity, bool) request) async {
    // - 주제를 설명할 때 '영상'이라는 단어를 사용하지 마세요.
    final videoEntity = request.$1;
    final hasBeenDivided = request.$2;

    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          '''
프로그래밍 관련 자막 데이터를 바탕으로, **프로그래밍 개념을 직접 가르치듯** 요약해 주세요.  
- 예) "노드 확장을 위해 소켓 아이오 어댑터를 활용하면 여러 클라이언트 연결을 효율적으로 처리할 수 있습니다."  
- 비예) "영상에서 발표자가 소켓 아이오 어댑터 활용을 통해 확장 전략을 설명해 주십니다."

### 주의:
1. **설명하는 주체가 직접 가르치듯** 서술해 주세요.
2. "영상에서 언급", "발표자가 말함" 등은 사용하지 마세요.  
3. "이 섹션에서는" 같은 표현 없이, **바로 개념**을 서술해 주세요.  
4. 단답형 표현 없이, **프로그래밍 지식을 모르는 독자에게 설명**하는 방식으로 작성해 주세요.
  

### 요구사항:
1. **세부 요약 목록(`summaries`) 작성**:
   - 각 섹션에 `title`(짧은 요약 제목), `contents`(설명 내용), `offset`(HH:MM:SS 또는 HH:MM:SS.sss 형식)을 기재하세요.
   - `contents`는 서술형 문장으로 구성해 주세요.
   - `contents`서로 다른 항목이어도 단순히 나열식("첫 번째 문장, 두 번째 문장...")이 아니라 설명 흐름이 자연스럽게 이어지도록 **앞뒤 맥락을 자연스럽게 이어** 주시면 좋습니다.
   - ${hasBeenDivided ? '**현재 구간(이 청크) 내에서만** 요약해 주시고, 다른 구간은 제외합니다.' : ''}
   
    
2. **입력 데이터 형식**:
   - **제목**: `${videoEntity.title}`
   - **자막(caption) 데이터**: `${videoEntity.captions.map((e) => e.toMap()).toList()}`

3. **응답 언어**:
   - 항상 **${AppLocale.currentLocale.languageCode}**로 언어를 구성해 주세요.

4. **어체**:
   - 경어체(존댓말)을 사용해 주시되, **바로 독자에게 설명**한다는 느낌을 유지해 주세요.

5. **응답 형식**:
   모든 응답은 다음 JSON 구조를 준수해야 합니다.
   ```json
   {
     "summaries": [
       {
         "title": "요약 제목",
         "contents": [
           "요약 내용1",
           "요약 내용2"
         ],
         "offset": "HH:MM:SS"
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

      final targetEntity = (targetJson['summaries'] as List<dynamic>)
          .map((e) => ParagraphEntity.fromJson(e as Map<String, dynamic>))
          .toList();

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
