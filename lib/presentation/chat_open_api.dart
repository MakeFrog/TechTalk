import 'dart:convert';
import 'package:dio/dio.dart';

class ChatOpenApi {
  final String apiKey;
  final Dio dio;

  ChatOpenApi(this.apiKey)
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.openai.com/v1',
            headers: {
              'Authorization': 'Bearer $apiKey',
            },
          ),
        );

  Future<String> chat(String message) async {
    final startTime = DateTime.now();
    final messages = [
      {
        'role': 'user',
        'content':
            "'Swift' 관련 기술 면접질문에 대해서 제가 올바르게 답변하는지 판단해주고 이유를 최대한 간략하게 설명해주세요"
      },
      {'role': 'system', 'content': '당연하죠. "Swift의 upcasting과 downcasting의 차이점에을 설명" 질문에 답해보세요. 답변 완성도에 따라 필수적으로 correct:, incorrect: , needFeedback: 단어을 문장 앞에 달아드리겠습니다.'},
      // {'role': 'system', 'content': '당연하죠. "Swift의 upcasting과 downcasting의 차이점에을 설명" 질문에 답해보세요. 정답 여부에 따라 필수적으로 correct:, incorrect: 단어을 문장 앞에 달아드리겠습니다.'},
      {'role': 'user', 'content': message},
    ];

    try {
      final response = await dio.post(
        '/chat/completions', // Chat Completions Beta 엔드포인트로 변경
        data: {
          'model': 'gpt-3.5-turbo', // 모델을 지정합니다.
          'messages': messages,
          'max_tokens': 500,
          'temperature': 0.8,
          'n': 1,
        },
      );

      final choice = response.data['choices'][0];
      final endTime = DateTime.now();
      // 걸린 시간 계산
      final duration = endTime.difference(startTime);

      // 걸린 시간 출력
      print('걸린 시간: ${duration.inSeconds}s');
      return choice['message']['content'].trim();
    } on DioError catch (e) {
      print(e.message);
      throw Exception('Error contacting Chat Completions Beta API');
    }
  }
}
