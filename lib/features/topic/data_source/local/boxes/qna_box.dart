import 'package:hive/hive.dart';
import 'package:techtalk/features/topic/data_source/remote/models/topic_qna_model.dart';
import 'package:techtalk/features/topic/repositories/entities/qna_entity.dart';

part 'qna_box.g.dart';

@HiveType(typeId: 1)
class QnaBox extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String question;

  @HiveField(2)
  final List<String> answers;

  QnaBox({required this.id, required this.question, required this.answers});

  factory QnaBox.fromModel(TopicQnaModel entity) =>
      QnaBox(id: entity.id, question: entity.question, answers: entity.answers);

  QnaEntity toEntity() {
    return QnaEntity(
      id: id,
      question: question,
      answers: answers,
    );
  }
}
