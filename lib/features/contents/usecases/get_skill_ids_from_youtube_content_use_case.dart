import 'dart:async';

import 'package:dart_openai/dart_openai.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/contents/repositories/entities/youtube_video_entity.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';

class GetSkillIdsFromYoutubeContentUseCase
    extends BaseUseCase<YoutubeVideoAndCaptionEntity, void> {
  @override
  FutureOr<void> call(YoutubeVideoAndCaptionEntity request) async {
    final allSkills = techSetRepository.getSkills();
    // the system message that will be sent to the request.
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          '''
          개발 관련 유튜브 영상을 기반으로 면접 질문과 요약 설명을 제공하려고 합니다.
          영상의 제목과 내용을 기반으로 충분한 요약을 제공하거나 개발 관련 영상인지 판단해주세요.
          또한 영상 내용에 해당하는 개발 스킬에 해당하는 id 값을 반환해야됩니다.
          제목 : ${request.title}
          내용 : ${(getFirstHalf(request.script))}
          주어진 개발 스킬 id 리스트 : ${allSkills.map((e) => e.id).toList()}
          

          무조건 아래와 같은 JSON 구조로 응답을 해야됩니다.
          {
           "skills : [], // 주어진 개발 스킬 id중 영상 내용과 연관되어 있는 id
           "type": (notTech 또는 lackOfContent 또는 isValid)  
           // 개발 영상이 아니라면 "notTech"
           // 개발 영상이지만 충분한 기술적인 면접 질문과 요약 설명을 제공하기 힘든 영상이라면 "lackOfContent"
           // 유효한 영상이라면 "isValid"
          }
          
          ''',
        ),
      ],
      role: OpenAIChatMessageRole.system,
    );

    OpenAIChatCompletionModel completion = await OpenAI.instance.chat.create(
      model: "gpt-4o",
      messages: [
        systemMessage,
      ],
      responseFormat: {"type": "json_object"},
      maxTokens: 500,
      temperature: 0.2,
    );

    print(
        '프롬프트 분석 결과랑이 : ${completion.choices.first.message.content}'); // 응답 결과 출력
  }

  String getFirstHalf(String input) {
    int midIndex = input.length ~/ 2; // 문자열 길이의 절반 (정수 나눗셈)
    return input.substring(0, midIndex); // 0부터 midIndex까지 자름
  }
}
