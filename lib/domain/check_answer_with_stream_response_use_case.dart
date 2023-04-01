import 'dart:async';

import 'package:chatgpt_completions/chatgpt_completions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CheckAnswerWithStreamResponseUseCase {
  // Stream 컨트롤러
  late final StreamController<String> streamController;
  StreamSubscription? _streamSubscription;

  final ChatGPTCompletions completions = ChatGPTCompletions.instance;

  Future<void> checkAnswer({
    required String category,
    required String question,
    required String userAnswer,
  }) async {
    final prompt =
        '$category 프로그래밍 분야에서 "$question"라는 프로그래밍 질문에,\n"$userAnswer" 라고 답한다면 옳은 답변일까?\n정답이라면 "[correct]" 오답이라면 "[incorrect]"라는 태그 단어를 문장 맨 앞에 붙여주고 이유도 간략하게 설명해줘.';
    await completions.textCompletions(
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
        streamController.add(characters);
      },
      onStreamCreated: (subscription) {
        // 스트림이 생성되면 StreamSubscription 객체를 할당
        _streamSubscription = subscription;
      },
    );
  }


  // 스트림을 중지 또는 일시 중지
  void stopStream() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel(); // 스트림 중지
      _streamSubscription = null;
    }
  }

  // StreamController를 disponse
  void disposeStreamController() {
    if (streamController.hasListener) {
      streamController.close();
    }
  }

  void initUseCase() {
    // Chat GPT 인스턴스 초기화
    ChatGPTCompletions.instance.initialize(apiKey: dotenv.env['OPENAPI_KEY']!);
    // StreamController 생성
    streamController = StreamController<String>();
  }
}
