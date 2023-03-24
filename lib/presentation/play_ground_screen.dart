import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moon_dap/presentation/chat_open_api.dart';
import 'package:moon_dap/presentation/open_api.dart';

class PlayGroundScreen extends StatefulWidget {
  @override
  _PlayGroundScreenState createState() => _PlayGroundScreenState();
}

class _PlayGroundScreenState extends State<PlayGroundScreen> {
  final _openaiApi = ChatOpenApi(dotenv.env['OPENAPI_KEY']!);
  final _controller = TextEditingController();

  void _handleQuestion(String question) async {
    final answer = await _openaiApi.chat(question);
    print('User : $question');
    print('$answer');
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
          ElevatedButton(
            onPressed: () {
              _handleQuestion(_controller.text);
            },
            child: Text('Ask GPT-4'),
          ),
        ],
      ),
    );
  }
}