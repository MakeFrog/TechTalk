import 'package:techtalk/features/chat/repositories/entities/base_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/qna_type.enum.dart';

///
/// 단골질문 문답
///
class CommonQnaEntity extends BaseQnaEntity {
  final List<String> answers; // 모범 답변 리스트

  CommonQnaEntity({
    required super.id,
    required super.question,
    required this.answers,
  }) : super(
          type: QnaType.common,
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommonQnaEntity &&
          runtimeType == other.runtimeType &&
          answers == other.answers &&
          id == other.id &&
          question == other.question;

  @override
  int get hashCode => answers.hashCode ^ id.hashCode ^ question.hashCode;

  CommonQnaEntity copyWith({
    List<String>? answers,
    String? id,
    String? question,
  }) {
    return CommonQnaEntity(
      answers: answers ?? this.answers,
      id: id ?? this.id,
      question: question ?? this.question,
    );
  }
}
