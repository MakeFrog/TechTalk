import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> connectToSSE() async {
  // SSE endpoint URL을 설정합니다.
  var url = Uri.parse('https://api.openai.com/v1/completions');

  // SSE endpoint URL에 GET 요청을 보냅니다.
  var client = http.Client();
  var request = http.Request('GET', url);
  request.headers['Authorization'] = 'Bearer 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';
  request.headers['OpenAI-Intent'] = 'text-davinci-003/completions';
  request.headers['Accept'] = 'text/event-stream';
  request.headers['prompt'] = 'Hello';
  var response = await client.send(request);

  // SSE 데이터를 처리하는 함수를 작성합니다.
  void handleSSEEvent(http.StreamedResponse response) {
    response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen((String event) {
      // SSE 데이터를 처리합니다.
      print(event);
    });
  }

  // SSE 데이터를 처리합니다.
  if (response.statusCode == 200) {
    handleSSEEvent(response);
  } else {
    print(response.reasonPhrase);
    print('SSE 연결 실패: ${response.statusCode}');
  }
}