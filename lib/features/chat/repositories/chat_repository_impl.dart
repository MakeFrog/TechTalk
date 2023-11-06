import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/entities/chat_entity.dart';
import 'package:techtalk/features/chat/entities/interview_qna_entity.dart';
import 'package:techtalk/features/chat/entities/received_chat_entity.dart';
import 'package:techtalk/features/chat/entities/sent_chat_entity.dart';
import 'package:techtalk/features/chat/entities/user_interview_response.dart';
import 'package:techtalk/features/chat/enums/answer_state.enum.dart';
import 'package:techtalk/features/chat/enums/chat_type.enum.dart';
import 'package:techtalk/features/chat/repositories/chat_repository.dart';

final class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<Result<List<ChatEntity>>> getChatList(String roomId) async {
    final List<ChatEntity> result = [
      ReceivedChatEntity.createStaticChat(
        message: 'Swift의 upcasting과 downcasting의 차이에 대해서 설명해보세요.',
        type: ChatType.askQuestion,
      ),
      ReceivedChatEntity.createStaticChat(
        message: '다음 문제 입니다',
        type: ChatType.guide,
      ),
      ReceivedChatEntity.createStaticChat(
        message:
            'Swift에서 upcasting과 downcasting의 개념을 이해 하는 데 도움이 될 수 있지만, 불완전하거나 정확하지 않은 부분이 있습니다.\nupcasting은 서로 상속 관계에 있는 클래스에서 자식 클래스를 부모 클래스로 타입캐스팅 하는 것이 맞습니다.',
        type: ChatType.replyToUserAnswer,
      ),
      SentChatEntity(
        message:
            '서로 상속 관계에 있는 클래스에서 자식 클래스를 부모 클래스로 타입 캐스팅 하는 것을 업 캐스팅이라고 하고, as를 사용해서 업 캐스팅할 수 있습니다.',
        answerState: AnswerState.correct,
      ),
      ReceivedChatEntity.createStaticChat(
        message: 'Swift의 upcasting과 downcasting의 차이에 대해서 설명해보세요',
        type: ChatType.askQuestion,
      ),
      ReceivedChatEntity.createStaticChat(
        message: '반가워요! 지혜님. Swift 면접 질문을 드리겠습니다.',
        type: ChatType.guide,
      ),
    ];

    return Result.success(result);
  }

  @override
  Future<List<InterviewQnAEntity>> getInitialQuestions(
    String subjectId,
  ) async {
    final List<InterviewQnAEntity> result = [
      InterviewQnAEntity.fromInitialQuestionModel(
          id: 'swift-32', question: '스위프트에서 Extension은 어떻게 사용되나요?'),
      InterviewQnAEntity.fromInitialQuestionModel(
          id: 'swift-334',
          question: 'Swift의 upcasting과 downcasting의 차이에 대해서 설명해보세요.'),
      // 추가된 질문들
      InterviewQnAEntity.fromInitialQuestionModel(
          id: 'swift-123', question: '두 개의 정수를 더하는 함수를 작성해보세요.'),
      InterviewQnAEntity.fromInitialQuestionModel(
          id: 'swift-456', question: '스위프트에서 옵셔널(Optional)이란 무엇인가요?'),
      InterviewQnAEntity.fromInitialQuestionModel(
          id: 'swift-789', question: 'iOS 앱 개발을 위한 주요 도구는 어떤 것들이 있나요?'),
      // 추가 질문들
      InterviewQnAEntity.fromInitialQuestionModel(
          id: 'swift-987', question: '클로저(Closure)란 무엇이며 어떻게 사용되나요?'),
      InterviewQnAEntity.fromInitialQuestionModel(
          id: 'swift-654', question: 'iOS에서 델리게이트(Delegate) 패턴을 설명해보세요.'),
      InterviewQnAEntity.fromInitialQuestionModel(
          id: 'swift-321',
          question: '스위프트에서 클래스(Class)와 구조체(Struct)의 차이는 무엇인가요?'),
      InterviewQnAEntity.fromInitialQuestionModel(
          id: 'swift-100', question: '스위프트에서 Guard 문장의 역할은 무엇인가요?'),
      InterviewQnAEntity.fromInitialQuestionModel(
          id: 'swift-999', question: 'SwiftUI를 사용하여 간단한 앱 화면을 만들어보세요.'),
    ];
    return Result.success(result).getOrThrow();
  }

  @override
  Future<Result<List<InterviewQnAEntity>>> getOngoingQnaList(
    String roomId,
  ) async {
    final List<InterviewQnAEntity> result = [
      InterviewQnAEntity.fromOngoingQnAModel(
        id: 'swift-999',
        question: '스위프트에서 Extension은 어떻게 사용되나요?',
        idealAnswer: ['모범 답변1', ' 모범답변2'],
        response: UserInterviewResponse(
          '잘 모르겠어요...',
          state: AnswerState.wrong,
        ),
      ),
      InterviewQnAEntity.fromOngoingQnAModel(
        id: 'swift-334',
        question: 'Swift의 upcasting과 downcasting의 차이에 대해서 설명해보세요.',
        idealAnswer: ['모범 답변1', ' 모범답변2'],
        response: UserInterviewResponse(
          '정답은 이겁니다',
          state: AnswerState.correct,
        ),
      ),

      InterviewQnAEntity.fromOngoingQnAModel(
        id: 'swift-123',
        question: '두 개의 정수를 더하는 함수를 작성해보세요.',
        idealAnswer: ['모범 답변1', ' 모범답변2'],
        response: UserInterviewResponse(
          '잘 모르겠어요...',
          state: AnswerState.wrong,
        ),
      ),
      InterviewQnAEntity.fromOngoingQnAModel(
        id: 'swift-456',
        question: '스위프트에서 옵셔널(Optional)이란 무엇인가요?',
        idealAnswer: ['모범 답변1', ' 모범답변2'],
        response: null,
      ),
      InterviewQnAEntity.fromOngoingQnAModel(
        id: 'swift-789',
        question: 'iOS 앱 개발을 위한 주요 도구는 어떤 것들이 있나요?',
        idealAnswer: ['모범 답변1', ' 모범답변2'],
        response: null,
      ),

      /// 여기서 부터는 모범 답변 리스트도 null로 받아들임
      InterviewQnAEntity.fromOngoingQnAModel(
        id: 'swift-987',
        question: '클로저(Closure)란 무엇이며 어떻게 사용되나요?',
        idealAnswer: null,
        response: null,
      ),
      InterviewQnAEntity.fromOngoingQnAModel(
        id: 'swift-654',
        question: 'iOS에서 델리게이트(Delegate) 패턴을 설명해보세요.',
        idealAnswer: null,
        response: null,
      ),
      InterviewQnAEntity.fromOngoingQnAModel(
        id: 'swift-321',
        question: '스위프트에서 클래스(Class)와 구조체(Struct)의 차이는 무엇인가요?',
        idealAnswer: null,
        response: null,
      ),
      InterviewQnAEntity.fromOngoingQnAModel(
        id: 'swift-100',
        question: '스위프트에서 Guard 문장의 역할은 무엇인가요?',
        idealAnswer: null,
        response: null,
      ),
      InterviewQnAEntity.fromOngoingQnAModel(
        id: 'swift-999',
        question: 'SwiftUI를 사용하여 간단한 앱 화면을 만들어보세요.',
        idealAnswer: null,
        response: null,
      ),
    ];

    return Result.success(result);
  }

  @override
  Future<Result<List<String>>> getIdealAnswers(String questionId) async {
    final List<String> result = ['모범답입니다1.', '모범답안입니다2'];

    return Result.success(result);
  }
}
