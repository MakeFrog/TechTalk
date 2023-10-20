import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/job/job.dart';
import 'package:techtalk/features/tech_skill/data/models/tech_skill_model.dart';

part 'user_data_model.freezed.dart';
part 'user_data_model.g.dart';

@freezed
class UserDataModel with _$UserDataModel {
  const factory UserDataModel({
    required String uid,
    String? nickname,
    List<String>? interestedJobGroupIdList,
    List<String>? techSkillIdList,
  }) = _UserDataModel;

  const UserDataModel._();

  Map<String, dynamic> toFirestore() {
    return {
      'nickname': nickname,
      'interested_job_group_id_list': interestedJobGroupIdList,
      'tech_skill_id_list': techSkillIdList,
    };
  }

  factory UserDataModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final json = snapshot.data()!..['uid'] = snapshot.id;

    return UserDataModel(
      uid: json['uid'],
      nickname: json['nickname'],
      interestedJobGroupIdList: json['interested_job_group_id_list'],
      techSkillIdList: json['tech_skill_id_list'],
    );
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
}
