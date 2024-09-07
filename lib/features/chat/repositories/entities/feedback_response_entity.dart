import 'package:techtalk/features/chat/chat.dart';

class FeedbackResponseEntity {
  final String feedback; // 면접자의 답변에 대한 피드백
  final int score; // 면접자의 답변에 대한 점수
  final bool isFollowUpQuestionNeeded; // 꼬리질문 필요 여부
  final ChatQnaEntity topicQuestion; // 메인 토픽 질문

  FeedbackResponseEntity(
      {required this.feedback,
      required this.score,
      required this.isFollowUpQuestionNeeded,
      required this.topicQuestion});

  factory FeedbackResponseEntity.fromJson(Map<String, dynamic> json, String feedback, ChatQnaEntity topicQuestion) {
    return FeedbackResponseEntity(
      feedback: feedback,
      score: json['score'],
      isFollowUpQuestionNeeded: json['isFollowUpQuestionNeeded'],
      topicQuestion: topicQuestion,
    );
  }

  FeedbackResponseEntity copyWith(
      {String? feedback, int? score, bool? isFollowUpQuestionNeeded, ChatQnaEntity? topicQuestion}) {
    return FeedbackResponseEntity(
      feedback: feedback ?? this.feedback,
      score: score ?? this.score,
      isFollowUpQuestionNeeded: isFollowUpQuestionNeeded ?? this.isFollowUpQuestionNeeded,
      topicQuestion: topicQuestion ?? this.topicQuestion,
    );
  }
}
