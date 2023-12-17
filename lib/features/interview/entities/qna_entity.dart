import 'package:techtalk/features/interview/data/models/qna_model.dart';

class QnaEntity {
  final String id;

  final String question;
  final List<String> answers;

  QnaEntity({
    required this.id,
    required this.question,
    required this.answers,
  });

  factory QnaEntity.fromModel(QnaModel model) {
    return QnaEntity(
      id: model.id,
      question: model.question,
      answers: model.answers,
    );
  }
}
