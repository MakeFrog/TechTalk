import 'package:techtalk/core/constants/job_group.enum.dart';

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
  final List<String> topicIds;

  final DateTime lastLoginDate;

  const UserEntity({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    required this.lastLoginDate,
    List<JobGroup>? jobGroups,
    List<String>? topicIds,
  })  : jobGroups = jobGroups ?? const [],
        topicIds = topicIds ?? const [];

  @override
  String toString() {
    return 'UserEntity{uid: $uid, profileImgUrl: $profileImgUrl, nickname: $nickname, jobGroups: $jobGroups, topicIds: $topicIds, lastLoginDate: $lastLoginDate}';
  }

  UserEntity copyWith({
    String? uid,
    String? profileImgUrl,
    String? nickname,
    List<JobGroup>? jobGroups,
    List<String>? topicIds,
    DateTime? lastLoginDate,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      nickname: nickname ?? this.nickname,
      jobGroups: jobGroups ?? this.jobGroups,
      topicIds: topicIds ?? this.topicIds,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
    );
  }
}
