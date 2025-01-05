// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';

class UserEntity {
  final String uid;
  final String? profileImgUrl;
  final String? nickname;
  final String? email;
  final List<JobGroup> jobGroups;
  final List<SkillEntity> skills;
  final List<TopicEntity> recordedTopics;
  final bool hasPracticalInterviewRecord;
  final int completedInterviewCount;
  final DateTime lastLoginDate;
  final DateTime signUpDate;
  final bool isReviewRequestAvailable;
  final int? loginCount;

  // 이력서
  final String? resumePdfPath;
  final String? resumePdfTitle;
  final String? resumePdfDate;
  final String? portfolioPdfPath;
  final String? portfolioPdfTitle;
  final String? portfolioPdfDate;

  const UserEntity({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    this.email,
    required this.jobGroups,
    required this.skills,
    required this.recordedTopics,
    required this.hasPracticalInterviewRecord,
    required this.completedInterviewCount,
    required this.lastLoginDate,
    required this.signUpDate,
    required this.isReviewRequestAvailable,
    this.loginCount,
    this.resumePdfPath,
    this.resumePdfTitle,
    this.resumePdfDate,
    this.portfolioPdfPath,
    this.portfolioPdfTitle,
    this.portfolioPdfDate,
  });

  factory UserEntity.fromModel(
    UserModel model, {
    required List<SkillEntity> skills,
    required UserBox box,
  }) {
    return UserEntity(
      loginCount: model.loginCount ?? 0,
      uid: model.uid,
      nickname: model.nickname,
      profileImgUrl: model.profileImgUrl,
      jobGroups: model.jobGroupIds != null
          ? model.jobGroupIds!.map(JobGroup.getById).toList()
          : [],
      recordedTopics: model.recordedTopicIds != null
          ? model.recordedTopicIds!.map(StoredTopics.getById).toList()
          : [],
      hasPracticalInterviewRecord: box.hasPracticalInterviewRecord,
      skills: skills,
      lastLoginDate: model.lastLoginDate,
      email: model.email,
      completedInterviewCount: model.completedInterviewCount ?? 0,
      isReviewRequestAvailable: box.isReviewRequestAvailable,
      signUpDate: model.signUpDate,
      resumePdfPath: box.resumePdfPath,
      resumePdfTitle: box.resumePdfTitle,
      resumePdfDate: box.resumePdfDate,
    );
  }

  UserEntity copyWith({
    String? uid,
    String? profileImgUrl,
    String? nickname,
    String? email,
    List<JobGroup>? jobGroups,
    List<SkillEntity>? skills,
    List<TopicEntity>? recordedTopics,
    bool? hasPracticalInterviewRecord,
    int? completedInterviewCount,
    DateTime? lastLoginDate,
    DateTime? signUpDate,
    bool? isReviewRequestAvailable,
    int? loginCount,
    String? resumePdfPath,
    String? resumePdfTitle,
    String? resumePdfDate,
    String? portfolioPdfPath,
    String? portfolioPdfTitle,
    String? portfolioPdfDate,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      jobGroups: jobGroups ?? this.jobGroups,
      skills: skills ?? this.skills,
      recordedTopics: recordedTopics ?? this.recordedTopics,
      hasPracticalInterviewRecord: hasPracticalInterviewRecord ?? this.hasPracticalInterviewRecord,
      completedInterviewCount: completedInterviewCount ?? this.completedInterviewCount,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      signUpDate: signUpDate ?? this.signUpDate,
      isReviewRequestAvailable: isReviewRequestAvailable ?? this.isReviewRequestAvailable,
      loginCount: loginCount ?? this.loginCount,
      resumePdfPath: resumePdfPath ?? this.resumePdfPath,
      resumePdfTitle: resumePdfTitle ?? this.resumePdfTitle,
      resumePdfDate: resumePdfDate ?? this.resumePdfDate,
      portfolioPdfPath: portfolioPdfPath ?? this.portfolioPdfPath,
      portfolioPdfTitle: portfolioPdfTitle ?? this.portfolioPdfTitle,
      portfolioPdfDate: portfolioPdfDate ?? this.portfolioPdfDate,
    );
  }
}
