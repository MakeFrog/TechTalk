import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data_model.freezed.dart';
part 'user_data_model.g.dart';

@freezed
class UserDataModel with _$UserDataModel {
  const factory UserDataModel({
    required String uid,
    String? nickname,
    List<String>? interestedJobGroupIds,
    List<String>? skillIds,
  }) = _UserDataModel;

  const UserDataModel._();

  Map<String, dynamic> toFirestore() {
    return {
      'nickname': nickname,
      'interested_job_group_ids': interestedJobGroupIds,
      'skill_ids': skillIds,
    };
  }

  factory UserDataModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final json = snapshot.data()!;

    return UserDataModel(
      uid: snapshot.id,
      nickname: json['nickname'] as String?,
      interestedJobGroupIds:
          (json['interested_job_group_ids'] as List?)?.cast<String>(),
      skillIds: (json['skill_ids'] as List?)?.cast<String>(),
    );
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
}
