import 'package:techtalk/core/constants/job_group.enum.dart';
import 'package:techtalk/core/constants/stored_topic.dart';
import 'package:techtalk/core/helper/list_extension.dart';
import 'package:techtalk/features/tech_set/repositories/entities/skill_entity.dart';
import 'package:techtalk/features/topic/repositories/entities/topic_entity.dart';
import 'package:techtalk/features/user/data_source/remote/models/user_model.dart';

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

  /// 면접을 진행한 면접 주제
  final List<TopicEntity> recordedTopics;

  /// 실실전 면접 기록 존재 여부;
  final bool hasPracticalInterviewRecord;

  /// 마지막 접속 일자
  final DateTime lastLoginDate;

  const UserEntity({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    required this.hasPracticalInterviewRecord,
    required this.recordedTopics,
    required this.lastLoginDate,
    required this.jobGroups,
    required this.skills,
  });

  factory UserEntity.fromModel(UserModel model,
      {required List<SkillEntity> skills,
      required bool hasPracticalInterviewRecord}) {
    return UserEntity(
      uid: model.uid,
      nickname: model.nickname,
      profileImgUrl: model.profileImgUrl,
      jobGroups: model.jobGroupIds != null
          ? model.jobGroupIds!.map(JobGroup.getById).toList()
          : [],
      recordedTopics: model.recordedTopicIds != null
          ? model.recordedTopicIds!.map(StoredTopics.getById).toList()
          : [],
      hasPracticalInterviewRecord: hasPracticalInterviewRecord,
      skills: skills,
      lastLoginDate: model.lastLoginDate,
    );
  }

  /// 면접 기록이 있는 주제와 관심 스킬과 연관돤 면접 주제
  List<TopicEntity> get targetedTopics {
    final List<TopicEntity> skillRelatedTopics = [];

    for (var skill in skills) {
      final relatedTopic = StoredTopics.getByIdOrNull(skill.id);
      if (relatedTopic != null) {
        skillRelatedTopics.add(relatedTopic);
      }
    }

    final combinedTopics = skillRelatedTopics.toCombinedSetList(recordedTopics);

    return combinedTopics;
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
    bool? hasPracticalInterviewRecord,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      nickname: nickname ?? this.nickname,
      recordedTopics: recordedTopicIds ?? this.recordedTopics,
      jobGroups: jobGroups ?? this.jobGroups,
      skills: skills ?? this.skills,
      hasPracticalInterviewRecord:
          hasPracticalInterviewRecord ?? this.hasPracticalInterviewRecord,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
    );
  }
}
