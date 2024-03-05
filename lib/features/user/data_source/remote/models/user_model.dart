import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/core/modules/converter/time_stamp_converter.dart';
import 'package:techtalk/features/user/repositories/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserModel {
  UserModel({
    required this.uid,
    required this.signUpDate,
    required this.lastLoginDate,
    this.loginCount,
    this.email,
    this.profileImgUrl,
    this.nickname,
    this.jobGroupIds,
    this.recordedTopicIds,
    this.completedInterviewCount,
    this.techSkills,
  });

  /// 유저 UID
  final String uid;

  /// 유저 email
  final String? email;

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

  /// 접속 횟수
  final int? loginCount;

  /// 완료된 면접 개수
  final int? completedInterviewCount;

  /// 가입 날짜
  @TimeStampConverter()
  final DateTime signUpDate;

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
      email: entity.email,
      signUpDate: entity.signUpDate,
      lastLoginDate: entity.lastLoginDate,
      completedInterviewCount: entity.completedInterviewCount,
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

  Map<String, dynamic> updatedFieldToJson() => {
        'profile_img_url': profileImgUrl,
        'nickname': nickname,
        'job_group_ids': jobGroupIds,
        'tech_skills': techSkills,
        'recorded_topic_ids': recordedTopicIds,
        'completed_interview_count': completedInterviewCount,
      };
}
