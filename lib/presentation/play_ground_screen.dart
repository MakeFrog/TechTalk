import 'dart:async';

import 'package:chatgpt_completions/chatgpt_completions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moon_dap/presentation/open_api.dart';

class PlayGroundScreen extends StatefulWidget {
  @override
  _PlayGroundScreenState createState() => _PlayGroundScreenState();
}

class _PlayGroundScreenState extends State<PlayGroundScreen> {
  final _openaiApi = OpenAIApi(dotenv.env['OPENAPI_KEY']!);
  final _controller = TextEditingController();
  final _streamController = StreamController<String>();

  void _handleQuestion(String question) async {
    final answer = await _openaiApi.chat(question);
    print('User : $question');
    print('$answer');
  }

  StreamSubscription? _streamSubscription;

  Future<void> testStreamGPT() async {
    ChatGPTCompletions.instance.initialize(apiKey: dotenv.env['OPENAPI_KEY']!);

    await ChatGPTCompletions.instance.textCompletions(
      TextCompletionsParams(
        prompt:
            'Flutter에서 "Mixin에 대해서 설명해보세요"라는 프로그래밍 질문에\n"다중 상속을 지원하는 키워드 입니다" 라고 답한다면 옳은 답변일까? 정답이라면 "[correct]" 오답이라면 "[incorrect]"라는 태그 단어를 문장 맨 앞에 붙여주고 이유도 간략하게 설명해줘.',
        model: GPTModel.davinci,
        temperature: 0.2,
        topP: 1,
        n: 1,
        stream: true,
        maxTokens: 500,
      ),
      onStreamValue: (characters) {
        _streamController.add(characters);
      },
      onStreamCreated: (subscription) {
        // 스트림이 생성되면 StreamSubscription 객체를 할당
        _streamSubscription = subscription;
      },
    );
  }

  // 스트림을 중지 또는 일시 중지하는 함수
  void stopStream() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel(); // 스트림 중지
      _streamSubscription = null;
    }
  }

  @override
  void dispose() {
    stopStream();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter your question',
            ),
          ),
          StreamBuilder<String>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final text = snapshot.data!;
                return Text(text);
              } else {
                return Text('Waiting for data...');
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              testStreamGPT();
            },
            child: Text('Ask GPT-4'),
          ),
        ],
      ),
    );
  }
}
