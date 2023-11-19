import 'dart:math';

import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

final class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<Result<List<ChatEntity>>> getChatList(String roomId) async {
    final List<ChatEntity> result = [
      QuestionChatEntity.createStaticChat(
        questionId: 'swift-29',
        idealAnswers: ['1', '2'],
        message: 'Swift의 upcasting과 downcasting의 차이에 대해서 설명해보세요22',
      ),
      GuideChatEntity.createStatic(
        '다음 문제 입니다',
      ),
      FeedbackChatEntity.createStatic('잘 답변하셨어요'),
      SentChatEntity(
        message: '옳바르게 답변한 내용입니다.',
        answerState: AnswerState.correct,
        questionId: 'swift-1',
      ),
      QuestionChatEntity.createStaticChat(
        questionId: 'swift-1',
        idealAnswers: ['1', '2'],
        message: 'Swift의 upcasting과 downcasting의 차이에 대해서 설명해보세요.',
      ),
      GuideChatEntity.createStatic(
        '반가워요! 지혜님. Swift 면접 질문을 드리겠습니다.',
      ),
    ];

    return Result.success(result);
  }

  @override
  Future<Result<List<String>>> getIdealAnswers(
      InterviewQuestionEntity questionId) async {
    final List<String> result = ['모범답입니다1.', '모범답안입니다2'];

    return Result.success(result);
  }

  @override
  Future<Result<InterviewQuestionEntity>> getRandomQuestion(
      String categoryId) async {
    final int randomNum = Random().nextInt(20);
    final InterviewQuestionEntity result = InterviewQuestionEntity(
      id: 'swift-$randomNum',
      content: LoremIpsumGenerator.generate(words: 10 + randomNum),
    );

    return Result.success(result);
  }
}
