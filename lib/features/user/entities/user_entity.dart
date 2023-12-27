class UserEntity {
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

  bool get hasEssentialData => nickname != null;

//<editor-fold desc="Data Methods">

  const UserEntity({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    List<String>? jobGroupIds,
    List<String>? topicIds,
  })  : jobGroupIds = jobGroupIds ?? const [],
        topicIds = topicIds ?? const [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserEntity &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          nickname == other.nickname &&
          jobGroupIds == other.jobGroupIds &&
          topicIds == other.topicIds);

  @override
  int get hashCode =>
      uid.hashCode ^
      nickname.hashCode ^
      jobGroupIds.hashCode ^
      topicIds.hashCode;

  @override
  String toString() {
    return 'UserEntity{' +
        ' uid: $uid,' +
        ' nickname: $nickname,' +
        ' jobGroupIds: $jobGroupIds,' +
        ' topicIds: $topicIds,' +
        '}';
  }

  UserEntity copyWith({
    String? uid,
    String? nickname,
    List<String>? jobGroupIds,
    List<String>? topicIds,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      jobGroupIds: jobGroupIds ?? this.jobGroupIds,
      topicIds: topicIds ?? this.topicIds,
    );
  }

//</editor-fold>
}
