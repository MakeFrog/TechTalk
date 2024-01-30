import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/features/tech_set/entities/skill_entity.dart';
import 'package:techtalk/features/topic/entities/topic_entity.dart';
import 'package:techtalk/features/user/data/models/user_model.dart';

class UserEntity {
  /// 유저 UID
  final String uid;

  /// 유저 프로필 이미지 URL
  final String? profileImgUrl;

  /// 유저 닉네임
  final String? nickname;

  /// 유저 관심 직군 ID 목록
  final List<JobGroup> jobGroups;

  /// 유저의 관심 테크 스킬 ID 목록
  final List<SkillEntity> skills;

  /// 한번이라도 면접을 진행한 면접 주제
  final List<TopicEntity> recordedTopicIds;

  final DateTime lastLoginDate;

  const UserEntity({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    required this.recordedTopicIds,
    required this.lastLoginDate,
    required this.jobGroups,
    required this.skills,
  });

  factory UserEntity.fromModel(UserModel model, List<SkillEntity> skills) {
    return UserEntity(
      uid: model.uid,
      nickname: model.nickname,
      profileImgUrl: model.profileImgUrl,
      jobGroups: model.jobGroupIds != null
          ? model.jobGroupIds!.map(JobGroup.getById).toList()
          : [],
      recordedTopicIds: model.recordedTopicIds != null
          ? model.recordedTopicIds!.map(StoredTopics.getById).toList()
          : [],
      skills: skills,
      lastLoginDate: model.lastLoginDate,
    );
  }

  @override
  String toString() {
    return 'UserEntity{uid: $uid, profileImgUrl: $profileImgUrl, nickname: $nickname, jobGroups: $jobGroups, skills: $skills, lastLoginDate: $lastLoginDate}';
  }

  UserEntity copyWith({
    String? uid,
    String? profileImgUrl,
    String? nickname,
    List<JobGroup>? jobGroups,
    List<TopicEntity>? recordedTopicIds,
    List<SkillEntity>? skills,
    DateTime? lastLoginDate,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      nickname: nickname ?? this.nickname,
      recordedTopicIds: recordedTopicIds ?? this.recordedTopicIds,
      jobGroups: jobGroups ?? this.jobGroups,
      skills: skills ?? this.skills,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
    );
  }
}
