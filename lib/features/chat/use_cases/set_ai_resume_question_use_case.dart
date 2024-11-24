import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/index.dart';

/// AI를 사용하여 이력서/포트폴리오 데이터를 분석하고 면접을 위한 Qna 엔티티 리스트를 생성하는 UseCase
/// String이 아닌 JSON을 반환해야 하지만 임시로
class SetAiResumeQuestionUseCase
    extends BaseUseCase<GetResumeParam, Result<String>> {
  @override
  Future<Result<String>> call(GetResumeParam param) async {
    try {
      // OpenAI에 요청을 보낼 ChatCompleteText 객체를 생성합니다.
      final chatRequest = ChatCompleteText(
        messages: _createResumeAnalysisPrompt(param),
        maxToken: 300,
        model: Gpt4ChatModel(),
        temperature: 0.5,
        user: FirebaseAuth.instance.currentUser!.uid,
      );

      // OpenAI API 단일 응답 호출
      final ChatCTResponse? response =
          await OpenAI.instance.onChatCompletion(request: chatRequest);

      // 응답 데이터에서 String으로 추출
      if (response?.choices == null || response!.choices.isEmpty) {
        throw Exception("Invalid response from OpenAI");
      }
      final rawContent = response.choices.first.message?.content ?? '';

      return Result.success(rawContent);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }

  List<Map<String, String>> _createResumeAnalysisPrompt(GetResumeParam param) {
    final promptContent = '''
  당신은 이력서/포트폴리오 분석을 도와주는 전문 AI 면접관입니다.
  아래는 지원자의 이력서 내용입니다:

  "${param.resumeOrPortfolioContent}"

  이 내용을 바탕으로 지원자에게 면접 시 물어볼 수 있는 적합한 질문 5개를 만들어주세요.
  각 질문은 간결하고 명확해야 합니다.
  ''';

    return [
      {
        'role': 'user',
        'content': promptContent,
      },
    ];
  }
}

/// 파라미터
typedef GetResumeParam = ({
  bool isFile,
  String? resumeOrPortfolioContent,
});
