class UserEntity {
  /// 유저 UID
  final String uid;

  /// 유저 프로필 이미지 URL
  final String? profileImgUrl;

  /// 유저 닉네임
  final String? nickname;

  /// 유저 관심 직군 ID 목록
  final List<String> jobGroupIds;

  /// 유저가 준비하고 있는 기술면접 주제 ID 목록
  final List<String> topicIds;

  final DateTime lastLoginDate;

//<editor-fold desc="Data Methods">
  const UserEntity({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    List<String>? jobGroupIds,
    List<String>? topicIds,
    required this.lastLoginDate,
  })  : jobGroupIds = jobGroupIds ?? const [],
        topicIds = topicIds ?? const [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserEntity &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          profileImgUrl == other.profileImgUrl &&
          nickname == other.nickname &&
          jobGroupIds == other.jobGroupIds &&
          topicIds == other.topicIds &&
          lastLoginDate == other.lastLoginDate);

  @override
  int get hashCode =>
      uid.hashCode ^
      profileImgUrl.hashCode ^
      nickname.hashCode ^
      jobGroupIds.hashCode ^
      topicIds.hashCode ^
      lastLoginDate.hashCode;

  @override
  String toString() {
    return 'UserEntity{' +
        ' uid: $uid,' +
        ' profileImgUrl: $profileImgUrl,' +
        ' nickname: $nickname,' +
        ' jobGroupIds: $jobGroupIds,' +
        ' topicIds: $topicIds,' +
        ' lastLoginDate: $lastLoginDate,' +
        '}';
  }

  UserEntity copyWith({
    String? uid,
    String? profileImgUrl,
    String? nickname,
    List<String>? jobGroupIds,
    List<String>? topicIds,
    DateTime? lastLoginDate,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      nickname: nickname ?? this.nickname,
      jobGroupIds: jobGroupIds ?? this.jobGroupIds,
      topicIds: topicIds ?? this.topicIds,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
    );
  }

//</editor-fold>
}
