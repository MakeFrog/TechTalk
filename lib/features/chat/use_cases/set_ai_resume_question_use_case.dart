import 'dart:convert';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/topic/repositories/entities/qna_entity.dart';
import 'package:uuid/uuid.dart';

class SetAiResumeQuestionUseCase
    extends BaseUseCase<GetResumeParam, Result<List<QnaEntity>>> {
  @override
  Future<Result<List<QnaEntity>>> call(GetResumeParam request) async {
    try {
      // OpenAI에 요청을 보낼 ChatCompleteText 객체 생성
      final chatRequest = ChatCompleteText(
        messages: _createResumeAnalysisPrompt(request),
        maxToken: 300,
        model: Gpt4ChatModel(),
        temperature: 0.5,
        user: FirebaseAuth.instance.currentUser!.uid,
      );

      // OpenAI API 단일 응답 호출
      final ChatCTResponse? response =
          await OpenAI.instance.onChatCompletion(request: chatRequest);

      // 응답 데이터가 유효한지 확인
      if (response?.choices == null || response!.choices.isEmpty) {
        throw Exception("OpenAI 응답이 유효하지 않습니다.");
      }

      // OpenAI 응답을 JSON으로 파싱
      final rawContent = response.choices.first.message?.content ?? '';

      final List<String> parsedQuestions = _parseQuestions(rawContent);

      // QnaEntity 리스트로 변환
      final List<QnaEntity> qnaEntities = parsedQuestions
          .map(
            (question) => QnaEntity(
              id: _generateUniqueId(),
              question: question,
              answers: [],
            ),
          )
          .toList();

      return Result.success(qnaEntities);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }

  List<Map<String, dynamic>> _createResumeAnalysisPrompt(GetResumeParam param) {
    final promptContent = '''
당신은 이력서/포트폴리오 분석을 도와주는 면접관이며, 유저는 지원자입니다.
아래는 지원자의 이력서 내용입니다:

"${param.resumeOrPortfolioContent}"

이 내용을 바탕으로 지원자의 기술적 역량(하드 스킬)과 대인관계, 문제 해결 능력 등 비기술적 역량(소프트 스킬)을 구분하여 면접에서 물어볼 수 있는 질문을 3~8개 만들어주세요.
응답은 반드시 JSON 형식의 리스트로 작성해주세요. 예:

["질문1", "질문2", "질문3", "질문4", "질문5"]

질문은 아래의 예시 기준으로 작성해주세요:
- (하드스킬) Flutter 개발 경험과 관련된 구체적인 문제 해결 사례를 물어볼 수 있는 질문
- (소프트스킬) 팀 협업 과정에서 어려움을 극복한 경험에 대한 질문

응답은 명확하고 직관적이어야 하며, JSON 형식을 엄격히 준수해야 합니다.
''';

    final messages = [
      Messages(role: Role.system, content: promptContent).toJson(),
      Messages(role: Role.user, content: promptContent).toJson(),
    ];
    return messages;
  }

  List<String> _parseQuestions(String rawContent) {
    try {
      // JSON 파싱
      final parsedJson = jsonDecode(rawContent);

      // JSON이 리스트 형태인지 확인
      if (parsedJson is List<dynamic>) {
        final questions = parsedJson.map((item) => item.toString()).toList();
        return questions;
      } else {
        throw Exception('JSON 형식이 올바르지 않습니다.');
      }
    } catch (e) {
      throw Exception('OpenAI 응답 파싱에 실패했습니다: $e');
    }
  }

  String _generateUniqueId() {
    const uuid = Uuid();
    return uuid.v4();
  }
}

/// 파라미터
typedef GetResumeParam = ({
  bool isFile,
  String resumeOrPortfolioContent,
});
