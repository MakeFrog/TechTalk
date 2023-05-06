import 'package:chatgpt_completions/chatgpt_completions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rxdart/rxdart.dart';

/** Created By Ximya - 2023.05.06
 *  ChatGPT 요청 및 응답을 관리하는 useCase 모듈
 *  [BehaviorSubject] 객체를 반환하여
 *  View레이어에서 독립적인 Stream 이벤트를 fetch 할 수 있도록 함.
 * */

class GetGptReplyUseCase {
  final ChatGPTCompletions completions = ChatGPTCompletions.instance;

  /// ChatGpt 응답을 요청하는 메소드
  /// [BehaviorSubject]을 리턴하여 독립적인 Stream 객체를 반환
  BehaviorSubject<String> getGptReplyOnStream({
    required String category,
    required String question,
    required String userAnswer,
  }) {
    final BehaviorSubject<String> messageSubject = BehaviorSubject<String>();

    final prompt =
        '$category 프로그래밍 분야에서 "$question"라는 프로그래밍 질문에,\n"$userAnswer" 라고 답한다면 옳은 답변일까?\n정답이라면 "[correct]" 오답이라면 "[incorrect]"라는 태그 단어를 문장 맨 앞에 붙여주고 이유도 간략하게 설명해줘.';
    completions.textCompletions(
      TextCompletionsParams(
        prompt: prompt,
        model: GPTModel.davinci,
        temperature: 0.2,
        topP: 1,
        n: 1,
        stream: true,
        maxTokens: 500,
      ),
      onStreamValue: (characters) {
        final filteredRes = formatString(characters);
        messageSubject.add(filteredRes);
        print(characters);
      },
    ).then((_) => messageSubject.close());

    return messageSubject;
  }

  /// 문자열 포맷
  /// 1. [incorrect] & [correct] 인디에키터 포맷
  /// 2. 불필요 줄바꿈 제거
  /// TODO: prompt를 고도화하면 해당 포맷 로직을 생략시킬 수 있을 듯
  String formatString(String response) {
    String originText = response.replaceAll("\n", '');

    if (originText.contains("[incorrect]")) {
      String cleanedText = originText.replaceFirst("[incorrect]", "").trim();
      return "오답입니다\n$cleanedText";
    } else {
      String cleanedText = originText.replaceFirst("[correct]", "").trim();
      return "정답니다\n$cleanedText";
    }
  }

  // Chat GPT 인스턴스 초기화
  void initUseCase() {
    ChatGPTCompletions.instance.initialize(apiKey: dotenv.env['OPENAPI_KEY']!);
  }
}
