import 'package:techtalk/features/topic/repositories/entities/qna_entity.dart';

class WrongAnswerEntity {
  final QnaEntity qna;
  final DateTime updatedAt;
  final String userAnswer;
  final int wrongAnswerCount;

  WrongAnswerEntity({
    required this.qna,
    required this.updatedAt,
    required this.userAnswer,
    required this.wrongAnswerCount,
  });
}
