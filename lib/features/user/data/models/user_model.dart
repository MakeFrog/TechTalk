import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/utils/time_stamp_converter.dart';
import 'package:techtalk/features/user/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserModel {
  UserModel({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    this.jobGroupIds,
    this.recordedTopicIds,
    this.techSkills,
    DateTime? lastLoginDate,
  }) : lastLoginDate = DateTime.now();

  /// 유저 UID
  final String uid;

  /// 유저 프로필 이미지 URL
  final String? profileImgUrl;

  /// 유저 닉네임
  final String? nickname;

  /// 유저 관심 직군 ID 목록
  final List<String>? jobGroupIds;

  /// 유저의 관심 테크 스킬 목록
  final List<String>? techSkills;

  /// 한번이라도 면접을 진행한 면접 주제
  final List<String>? recordedTopicIds;

  /// 마지막 로그인 시간
  @TimeStampConverter()
  final DateTime lastLoginDate;

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      profileImgUrl: entity.profileImgUrl,
      nickname: entity.nickname,
      recordedTopicIds: entity.recordedTopics.map((e) => e.id).toList(),
      jobGroupIds: entity.jobGroups.map((e) => e.id).toList(),
      techSkills: entity.skills.map((e) => e.id).toList(),
    );
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      UserModel.fromJson(snapshot.data()!);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
