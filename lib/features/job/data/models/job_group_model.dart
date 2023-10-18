import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_group_model.freezed.dart';
part 'job_group_model.g.dart';

@freezed
class JobGroupModel with _$JobGroupModel {
  const factory JobGroupModel({
    required String id,
    required String name,
  }) = _JobGroupModel;

  factory JobGroupModel.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()..['id'] = snapshot.id;

    return JobGroupModel.fromJson(data);
  }

  factory JobGroupModel.fromJson(Map<String, dynamic> json) =>
      _$JobGroupModelFromJson(json);
}
