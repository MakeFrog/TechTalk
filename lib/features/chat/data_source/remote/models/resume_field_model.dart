import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:techtalk/features/chat/repositories/enums/resume_question_type.enum.dart';

part 'resume_field_model.g.dart';

///
/// 1.1.0 (이력서 면접)
/// 이력서 qna일 경우 매핑되어야하는 데이터 셋
///
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ResumeFieldModel {
  final String question;
  final String evaluationPoint;
  final ResumeQuestionType questionType;

  ResumeFieldModel({
    required this.question,
    required this.evaluationPoint,
    required this.questionType,
  });

  factory ResumeFieldModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      ResumeFieldModel.fromJson(snapshot.data()!);

  factory ResumeFieldModel.fromJson(Map<String, dynamic> json) {
    return _$ResumeFieldModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResumeFieldModelToJson(this);
}
