import 'package:techtalk/features/chat/repositories/entities/base_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/qna_type.enum.dart';
import 'package:techtalk/features/topic/data_source/remote/models/topic_qna_model.dart';

///
/// 유튜브 콘텐츠 기반 문답
///

class YoutubeQnaEntity extends BaseQnaEntity {
  /// 평가 요소
  final String evaluationPoint;

  const YoutubeQnaEntity({
    required super.id,
    required super.question,
    required this.evaluationPoint,
  }) : super(
          type: QnaType.youtube,
        );

  YoutubeQnaEntity copyWith({
    String? evaluationPoint,
    String? id,
    String? question,
  }) {
    return YoutubeQnaEntity(
      evaluationPoint: evaluationPoint ?? this.evaluationPoint,
      id: id ?? this.id,
      question: question ?? this.question,
    );
  }

  factory YoutubeQnaEntity.fromModel(TopicQnaModel model) => YoutubeQnaEntity(
        id: model.id,
        question: model.question,
        evaluationPoint: model.questionInstruction ?? '없음',
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YoutubeQnaEntity &&
          runtimeType == other.runtimeType &&
          evaluationPoint == other.evaluationPoint &&
          id == other.id &&
          question == other.question &&
          type == other.type;

  @override
  int get hashCode =>
      evaluationPoint.hashCode ^
      id.hashCode ^
      question.hashCode ^
      type.hashCode;
}
