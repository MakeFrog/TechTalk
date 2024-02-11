import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/utils/time_stamp_converter.dart';
import 'package:techtalk/features/chat/chat.dart';

part 'wrong_answer_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class WrongAnswerModel {
  final String id;
  @TimeStampConverter()
  final DateTime updatedAt;
  final String userAnswer;
  final int wrongAnswerCount;

  WrongAnswerModel({
    required this.id,
    required this.updatedAt,
    required this.userAnswer,
    required this.wrongAnswerCount,
  });

  factory WrongAnswerModel.fromEntity(ChatQnaEntity entity) => WrongAnswerModel(
        id: entity.id,
        updatedAt: DateTime.now(),
        userAnswer: entity.message!.message.value,
        wrongAnswerCount: 1,
      );

  factory WrongAnswerModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      WrongAnswerModel.fromJson(snapshot.data()!);

  factory WrongAnswerModel.fromJson(Map<String, dynamic> json) {
    return _$WrongAnswerModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WrongAnswerModelToJson(this);
}
