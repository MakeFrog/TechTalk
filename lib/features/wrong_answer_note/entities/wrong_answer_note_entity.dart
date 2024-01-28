import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/wrong_answer_note/entities/wrong_answer_note_answer_entity.dart';

class WrongAnswerNoteEntity {
  final String id;
  final QnaEntity question;
  final List<WrongAnswerNoteAnswerEntity> answers;

//<editor-fold desc="Data Methods">
  const WrongAnswerNoteEntity({
    required this.id,
    required this.question,
    required this.answers,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WrongAnswerNoteEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          question == other.question &&
          answers == other.answers);

  @override
  int get hashCode => id.hashCode ^ question.hashCode ^ answers.hashCode;

  @override
  String toString() {
    return 'WrongAnswerNoteEntity{' +
        ' id: $id,' +
        ' question: $question,' +
        ' answers: $answers,' +
        '}';
  }

  WrongAnswerNoteEntity copyWith({
    String? id,
    QnaEntity? question,
    List<WrongAnswerNoteAnswerEntity>? answers,
  }) {
    return WrongAnswerNoteEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
    );
  }

//</editor-fold>
}
