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

  bool get hasEssentialData => nickname != null;

  const UserEntity({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    List<String>? jobGroupIds,
    List<String>? topicIds,
  })  : jobGroupIds = jobGroupIds ?? const [],
        topicIds = topicIds ?? const [];

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'profileImgUrl': this.profileImgUrl,
      'nickname': this.nickname,
      'jobGroupIds': this.jobGroupIds,
      'topicIds': this.topicIds,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          jobGroupIds == other.jobGroupIds;

  @override
  int get hashCode => jobGroupIds.hashCode;

  UserEntity copyWith({
    String? uid,
    String? profileImgUrl,
    String? nickname,
    List<String>? jobGroupIds,
    List<String>? topicIds,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      nickname: nickname ?? this.nickname,
      jobGroupIds: jobGroupIds ?? this.jobGroupIds,
      topicIds: topicIds ?? this.topicIds,
    );
  }
}
