import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/tech_set/entities/skill_entity.dart';
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

  /// 유저가 준비하고 있는 기술면접 주제 ID 목록
  final List<SkillEntity> skills;

  final DateTime lastLoginDate;

  const UserEntity({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
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
    List<SkillEntity>? skills,
    DateTime? lastLoginDate,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      nickname: nickname ?? this.nickname,
      jobGroups: jobGroups ?? this.jobGroups,
      skills: skills ?? this.skills,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
    );
  }
}
