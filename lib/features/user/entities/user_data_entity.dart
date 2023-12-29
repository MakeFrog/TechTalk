class UserDataEntity {
  final String uid;
  final String? profileImgUrl;
  final String? nickname;
  final List<String> jobGroupIds;
  final List<String> topicIds;

  bool get hasEssentialData => nickname != null;

  const UserDataEntity({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    List<String>? jobGroupIds,
    List<String>? topicIds,
  })  : jobGroupIds = jobGroupIds ?? const [],
        topicIds = topicIds ?? const [];

  UserDataEntity copyWith({
    String? uid,
    String? profileImgUrl,
    String? nickname,
    List<String>? jobGroupIds,
    List<String>? topicIds,
  }) {
    return UserDataEntity(
      uid: uid ?? this.uid,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      nickname: nickname ?? this.nickname,
      jobGroupIds: jobGroupIds ?? this.jobGroupIds,
      topicIds: topicIds ?? this.topicIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'profileImgUrl': this.profileImgUrl,
      'nickname': this.nickname,
      'jobGroupIds': this.jobGroupIds,
      'topicIds': this.topicIds,
    };
  }

  factory UserDataEntity.fromMap(Map<String, dynamic> map) {
    return UserDataEntity(
      uid: map['uid'] as String,
      profileImgUrl: map['profileImgUrl'] as String,
      nickname: map['nickname'] as String,
      jobGroupIds: map['jobGroupIds'] as List<String>,
      topicIds: map['topicIds'] as List<String>,
    );
  }
}
