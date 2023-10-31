import 'package:techtalk/features/chat/entities/user_interview_response.dart';

class InterviewQnAEntity {
  final String id; // 질문 Id
  final String question; // 질문
  List<String>? idealAnswer; // 모범 답변 리스트
  UserInterviewResponse? response; // 유저 응답

  InterviewQnAEntity({
    required this.id,
    required this.question,
    required this.idealAnswer,
    required this.response,
  });

  bool get hasUserResponded => response != null;

  /// 최초 질문 리스트를 불러올 때
  factory InterviewQnAEntity.fromInitialQuestionModel({
    required String id,
    required String question,
  }) {
    return InterviewQnAEntity(
      id: id,
      question: question,
      response: null,
      idealAnswer: null,
    );
  }

  /// 진행중인 QnA 리스트를 불러올 때
  factory InterviewQnAEntity.fromOngoingQnAModel({
    required String id,
    required String question,
    required List<String>? idealAnswer,
    required UserInterviewResponse? response,
  }) {
    return InterviewQnAEntity(
      id: id,
      question: question,
      response: response,
      idealAnswer: idealAnswer,
    );
  }
}
