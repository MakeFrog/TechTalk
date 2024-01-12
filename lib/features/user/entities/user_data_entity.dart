import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/features/tech_set/entities/skill_entity.dart';
import 'package:techtalk/features/user/data/models/user_data_model.dart';

class UserDataEntity {
  final String uid;
  final String? profileImgUrl;
  final String? nickname;
  final List<JobGroup> jobGroups;
  final List<SkillEntity> skills;

  bool get hasEssentialData => nickname != null;

  const UserDataEntity({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    required this.jobGroups,
    required this.skills,
  });

  factory UserDataEntity.fromModel(
      UserDataModel model, List<SkillEntity> skills) {
    return UserDataEntity(
      uid: model.uid,
      nickname: model.nickname,
      profileImgUrl: model.profileImgUrl,
      jobGroups: model.jobGroupIds != null
          ? model.jobGroupIds!.map(JobGroup.getById).toList()
          : [],
      skills: skills,
    );
  }

  @override
  String toString() {
    return 'UserDataEntity{uid: $uid, profileImgUrl: $profileImgUrl, nickname: $nickname, jobGroups: $jobGroups, skills: $skills}';
  }

  UserDataEntity copyWith({
    String? uid,
    String? profileImgUrl,
    String? nickname,
    List<JobGroup>? jobGroups,
    List<SkillEntity>? skills,
  }) {
    return UserDataEntity(
      uid: uid ?? this.uid,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      nickname: nickname ?? this.nickname,
      jobGroups: jobGroups ?? this.jobGroups,
      skills: skills ?? this.skills,
    );
  }
}
