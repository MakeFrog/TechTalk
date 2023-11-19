import 'package:collection/collection.dart';
import 'package:techtalk/core/utils/base/base_no_future_use_case.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';

class RetrieveQnaListFromChatListUseCase extends BaseNoFutureUseCase<
    List<ChatEntity>, Result<List<InterviewQnAEntity>>> {
  @override
  Result<List<InterviewQnAEntity>> call(List<ChatEntity> chatList) {
    try {
      final questionList = getQuestionListFromChats(chatList);
      updateAnswerListFromChats(chatList, questionList);
      return Result.success(questionList);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  ///
  /// 채팅 리스트로부터 [질문 리스트] 데이터 반환
  ///
  List<InterviewQnAEntity> getQuestionListFromChats(List<ChatEntity> chatList) {
    List<InterviewQnAEntity> questions = [];

    for (int i = chatList.length - 1; i >= 0; i--) {
      ChatEntity chat = chatList[i];

      // 현재 채팅이 질문 메시지인지 확인
      if (chat.type.isAskQuestionMessage) {
        final questionChat = chat as QuestionChatEntity;

        // InterviewQnAEntity를 만들어서 목록에 추가
        questions.add(
          InterviewQnAEntity.fromInitialQuestionModel(
            id: questionChat.questionId,
            question: questionChat.message.value,
            idealAnswer: questionChat.idealAnswers,
          ),
        );
      }
    }

    return questions;
  }

  ///
  /// 반환 받은 [질문 리스트]와 채팅 리스트를 기반하여
  /// [답변 리스트] 업데이트
  ///
  void updateAnswerListFromChats(
      List<ChatEntity> chatList, List<InterviewQnAEntity> questions) {
    for (ChatEntity chat in chatList) {
      if (chat.type.isSentMessage) {
        final sentChat = chat as SentChatEntity;
        final selectedQnaItem = questions
            .firstWhereOrNull((question) => question.id == sentChat.questionId);

        if (selectedQnaItem != null) {
          selectedQnaItem.response = UserInterviewResponse(
            sentChat.message.value,
            state: sentChat.answerState,
          );
        }
      }
    }
  }
}
