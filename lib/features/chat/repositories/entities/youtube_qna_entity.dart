import 'package:techtalk/features/chat/repositories/entities/base_qna_entity.dart';
import 'package:techtalk/features/chat/repositories/enums/qna_type.enum.dart';
import 'package:techtalk/features/topic/data_source/remote/models/topic_qna_model.dart';
import 'package:uuid/uuid.dart';

///
/// 유튜브 콘텐츠 기반 문답
///

class YoutubeQnaEntity extends BaseQnaEntity {
  /// 평가 요소
  final String answer;
  final bool isSelected;

  YoutubeQnaEntity({
    required super.id,
    required super.question,
    required this.answer,
    this.isSelected = true,
  }) : super(
          type: QnaType.youtube,
        );

  YoutubeQnaEntity copyWith({
    String? answer,
    String? id,
    String? question,
    bool? isSelected,
  }) {
    return YoutubeQnaEntity(
      answer: answer ?? this.answer,
      id: id ?? this.id,
      question: question ?? this.question,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory YoutubeQnaEntity.fromJson(Map<String, dynamic> json) {
    ///[NOTE]
    ///Uuid 생성시 const를 사용하면
    ///컴파일 타임에 값이 생성됨.
    return YoutubeQnaEntity(
      id: Uuid().v1(),
      question: json['question'] as String,
      answer: json['answer'] as String,
    );
  }

  factory YoutubeQnaEntity.fromModel(TopicQnaModel model) => YoutubeQnaEntity(
        id: model.id,
        question: model.question,
        answer: model.questionInstruction ?? '없음',
      );
}
