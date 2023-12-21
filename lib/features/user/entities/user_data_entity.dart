class UserDataEntity {
  final String uid;
  final String? nickname;
  final List<String> jobGroupIds;
  final List<String> topicIds;

  bool get hasEssentialData => nickname != null;

//<editor-fold desc="Data Methods">

  const UserDataEntity({
    required this.uid,
    this.nickname,
    List<String>? jobGroupIds,
    List<String>? topicIds,
  })  : jobGroupIds = jobGroupIds ?? const [],
        topicIds = topicIds ?? const [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDataEntity &&
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
    return 'UserDataEntity{' +
        ' uid: $uid,' +
        ' nickname: $nickname,' +
        ' jobGroupIds: $jobGroupIds,' +
        ' topicIds: $topicIds,' +
        '}';
  }

  UserDataEntity copyWith({
    String? uid,
    String? nickname,
    List<String>? jobGroupIds,
    List<String>? topicIds,
  }) {
    return UserDataEntity(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      jobGroupIds: jobGroupIds ?? this.jobGroupIds,
      topicIds: topicIds ?? this.topicIds,
    );
  }

//</editor-fold>
}
