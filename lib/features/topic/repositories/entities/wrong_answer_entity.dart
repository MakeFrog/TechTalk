import 'package:techtalk/features/topic/repositories/entities/common_qna_entity.dart';

class WrongAnswerEntity {
  final CommonQnaEntity qna;
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
