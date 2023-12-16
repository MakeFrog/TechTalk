import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserDataModel {
  UserDataModel({
    required this.uid,
    this.nickname,
    this.jobGroupIds,
    this.topicIds,
  });

  final String? uid;
  final String? nickname;
  final List<String>? jobGroupIds;
  final List<String>? topicIds;

  Map<String, dynamic> toFirestore() => toJson();

  factory UserDataModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) =>
      UserDataModel.fromJson(snapshot.data()!);

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return _$UserDataModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}
