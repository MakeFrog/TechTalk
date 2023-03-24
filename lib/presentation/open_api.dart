import 'dart:convert';
import 'package:dio/dio.dart';

class OpenAIApi {
  final String apiKey;
  final Dio dio;

  OpenAIApi(this.apiKey)
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.openai.com/v1/engines',
            headers: {
              'Authorization': 'Bearer $apiKey',
            },
          ),
        );

  Future<String> chat(String message) async {
    const String question = "(Swift 관련): Swift에서 값 타입과 참조 타입의 차이는 무엇입니까?";
    String userAnswer = message;
    try {
      final response = await dio.post(
        '/text-davinci-003/completions', // GPT-3.5 모델 사용
        data: {
          'prompt': [
            '질문 : (Swift 관련): Swift에서 값 타입과 참조 타입의 차이는 무엇입니까?',
            '유저의 답변: $userAnswer',
            '위 질문에 대한 유저의 응답이 적절한지 판단해주세요. 그리고 간략하고 간단하게 이유를 설명해주세요.',
            '면접관이 사용하는 언어로 자연스럽게 답변해주세요.',
            '유저의 응답이 정답의 유사하면. "정답입니다..." 라는 선행문구로 시작합니다.',
            '유저의 응답 중 틀린 부분이 하나라도 있으면 "틀렸습니다" 라는 선행 문구로 시작합니다.',
            '유저의 응답이 모르겠다고 전달되면 정확한 답변을 알려줍니다.',
            '유저의 응답이 정답에 근접하지만 보충이 필요하다고 판단되면. "정답입니다. 하지만 보충할 부분이 있어요" 라는 선행 문구로 시작합니다.'
          ].join('\n'),
          'max_tokens': 500,
          'temperature': 1,
          'n': 1,
        },
      );

      final choice = response.data['choices'][0];
      return choice['text'].trim();
    } on DioError catch (e) {
      print(e.message);
      throw Exception('Error contacting GPT-3.5 API');
    }
  }
}
