import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/constants/job_group.enum.dart';
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
    this.topicIds,
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

  /// 유저가 준비하고 있는 기술면접 주제 ID 목록
  final List<String>? topicIds;

  /// 마지막 로그인 시간
  @TimeStampConverter()
  final DateTime lastLoginDate;

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      profileImgUrl: entity.profileImgUrl,
      nickname: entity.nickname,
      jobGroupIds: entity.jobGroups.map((e) => e.id).toList(),
      topicIds: entity.topicIds,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      profileImgUrl: profileImgUrl,
      nickname: nickname,
      jobGroups: jobGroupIds?.map((e) => JobGroup.getById(e)).toList(),
      topicIds: topicIds,
      lastLoginDate: lastLoginDate,
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
