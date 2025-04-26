import 'package:techtalk/features/chat/repositories/entities/base_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/qna_type.enum.dart';
import 'package:techtalk/features/tech_set/repositories/entities/tech_set_entity.dart';
import 'package:uuid/uuid.dart';

///
/// 단골질문 문답
///
class ProficiencyQnaEntity extends BaseQnaEntity {
  final List<String> answers; // 모범 답변 리스트
  final TechSetEntity techSet; // 스킬 or 직군

  String get techSetId => techSet.id;

  ProficiencyQnaEntity({
    required super.id,
    required super.question,
    required this.techSet,
    required this.answers,
  }) : super(
          type: QnaType.proficiency,
        );

  /// GPT 응답으로부터 엔티티 생성
  factory ProficiencyQnaEntity.fromGptResponse({
    required Map<String, dynamic> json,
  }) {
    return ProficiencyQnaEntity(
      id: const Uuid().v4(),
      question: json['question'] as String,
      answers: (json['answer'] as List<dynamic>).cast<String>(),
      techSet: TechSetEntity.mappedFromId(json['techSetId']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProficiencyQnaEntity &&
          runtimeType == other.runtimeType &&
          answers == other.answers &&
          id == other.id &&
          question == other.question;

  @override
  int get hashCode => answers.hashCode ^ id.hashCode ^ question.hashCode;

  ProficiencyQnaEntity copyWith({
    List<String>? answers,
    String? id,
    String? question,
    TechSetEntity? techSet,
  }) {
    return ProficiencyQnaEntity(
      answers: answers ?? this.answers,
      id: id ?? this.id,
      question: question ?? this.question,
      techSet: techSet ?? this.techSet,
    );
  }
}
