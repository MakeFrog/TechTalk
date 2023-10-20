import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
      'interestedJobGroupIdList': interestedJobGroupIdList,
      'techSkillIdList': techSkillIdList,
    };
  }

  factory UserDataModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final json = snapshot.data()!..['uid'] = snapshot.id;

    return UserDataModel.fromJson(json);
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
}
