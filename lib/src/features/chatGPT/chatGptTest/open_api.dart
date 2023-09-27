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

  // '나는 너가 프로그래머 면접관처럼 행동했으면 좋겠어. 나를 지원자라고 생각해. Swift 프로그래밍에 관련 질문이야. 질문: == 연산자와 === 연산자는 어떻게 다른가요?. 답변:$message. 모범답변: == 연산자는 값을 비교하는데 사용되고, === 연산자는 참조 값을 비교하는데 사용됩니다. 모범답변을 기준으로 답변을 0~10 사이의 점수로 엄격하게 평가해줘. 점수가 9~10 사이라면 "[correct]" 0~6 사이라면 "[incorrect]" 라는 태그 단어를 문장 제일 앞에 필수적으로 적어줘. 태그 단어 이후에는 답변에 대해 설명해줘. 점수는 절대 알려주지마.',
  Future<String> chat(String message) async {
    const String question = "(Swift 관련): Swift에서 값 타입과 참조 타입의 차이는 무엇입니까?";
    final startTime = DateTime.now();
    try {
      final response = await dio.post(
        '/text-davinci-003/completions', // GPT-3.5 모델 사용
        data: {
          'prompt':
          '$question\n\n[Answer] 답변을 입력해주세요. 정답 여부를 판별해주세요. 정답이라면 [correct] 오답이라면 [incorrect] 태그 문자를 문장 제일 앞에 필수적으로 적어줘. 태그 단어 이후에는 답변에 대해 설명해줘.',
          'max_tokens': 500,
          'temperature': 1,
          'top_p': 1,
          'frequency_penalty': 0,
          'presence_penalty': 0,
        },
      );

      final choice = response.data['choices'][0];

      final endTime = DateTime.now();
      // 걸린 시간 계산
      final duration = endTime.difference(startTime);

      // 걸린 시간 출력
      print('걸린 시간: ${duration.inSeconds}s');

      // OpenAI API가 반환한 응답 메시지에서 정답 여부를 확인하여, 적절한 메시지를 반환
      if (choice['text'].startsWith('[correct]')) {
        // 정답인 경우
        final explanation = choice['text'].replaceAll('[correct]', '').trim();
        return '정답입니다! $explanation';
      } else {
        // 오답인 경우
        final reason = choice['text'].replaceAll('[incorrect]', '').trim();
        return '오답입니다. $reason';
      }
    } on DioError catch (e) {
      print(e.message);
      throw Exception('Error contacting GPT-3.5 API');
    }
  }
}
