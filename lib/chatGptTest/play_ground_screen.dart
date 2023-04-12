import 'package:flutter/material.dart';
import 'package:moon_dap/chatGptTest/useCase/check_answer_with_stream_response_use_case.dart';


class PlayGroundScreen extends StatefulWidget {
  const PlayGroundScreen({super.key});

  @override
  _PlayGroundScreenState createState() => _PlayGroundScreenState();
}

class _PlayGroundScreenState extends State<PlayGroundScreen> {

  late final CheckAnswerWithStreamResponseUseCase useCase;

  @override
  void initState() {
    useCase = CheckAnswerWithStreamResponseUseCase();
    useCase.initUseCase();
    super.initState();
  }

  @override
  void dispose() {
    useCase.stopStream();
    useCase.disposeStreamController();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: StreamBuilder<String>(
              stream: useCase.streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final text = snapshot.data!;
                  return Text(text);
                } else {
                  return const Text('Waiting for data...');
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              const String question = 'Mixin의 용도는 무엇인가요?';
              const String category = 'Flutter';
              const String answer = '다중 상속을 할 때 사용하는 키워드야 ';
              useCase.checkAnswer(category: category, question: question, userAnswer: answer);
            },
            child: const Text('Ask GPT-4'),
          ),
        ],
      ),
    );
  }
}
