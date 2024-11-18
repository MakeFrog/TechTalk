import 'package:techtalk/core/index.dart';
import 'package:techtalk/features/tech_set/tech_set.dart';
import 'package:techtalk/features/topic/topic.dart';
import 'package:techtalk/features/user/user.dart';

class UserEntity {
  /// 유저 UID
  final String uid;

  /// 유저 프로필 이미지 URL
  final String? profileImgUrl;

  /// 유저 닉네임
  final String? nickname;

  /// 유저 이메일
  final String? email;

  /// 유저 관심 직군 ID 목록
  final List<JobGroup> jobGroups;

  /// 유저의 관심 테크 스킬 ID 목록
  final List<SkillEntity> skills;

  /// 면접을 진행한 면접 주제
  final List<TopicEntity> recordedTopics;

  /// 실전 면접 기록 존재 여부;
  final bool hasPracticalInterviewRecord;

  /// 완료된 면접 개수
  final int completedInterviewCount;

  /// 마지막 접속 일자
  final DateTime lastLoginDate;

  /// 가입 일자
  final DateTime signUpDate;

  /// 앱 리뷰 가능 여부
  final bool isReviewRequestAvailable;

  /// 로그인 횟수
  final int? loginCount;

  const UserEntity({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    this.email,
    this.loginCount,
    required this.signUpDate,
    required this.completedInterviewCount,
    required this.isReviewRequestAvailable,
    required this.hasPracticalInterviewRecord,
    required this.recordedTopics,
    required this.lastLoginDate,
    required this.jobGroups,
    required this.skills,
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
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      jobGroups: jobGroups ?? this.jobGroups,
      skills: skills ?? this.skills,
      recordedTopics: recordedTopics ?? this.recordedTopics,
      hasPracticalInterviewRecord:
          hasPracticalInterviewRecord ?? this.hasPracticalInterviewRecord,
      completedInterviewCount:
          completedInterviewCount ?? this.completedInterviewCount,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      signUpDate: signUpDate ?? this.signUpDate,
      isReviewRequestAvailable:
          isReviewRequestAvailable ?? this.isReviewRequestAvailable,
    );
  }
}
