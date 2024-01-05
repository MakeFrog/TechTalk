import 'package:techtalk/core/constants/job_group.enum.dart';

class UserDataEntity {
  final String uid;
  final String? profileImgUrl;
  final String? nickname;
  final List<JobGroup> jobGroups;
  final List<String> topicIds;

  bool get hasEssentialData => nickname != null;

  const UserDataEntity({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    List<JobGroup>? jobGroupIds,
    List<String>? topicIds,
  })  : jobGroups = jobGroupIds ?? const [],
        topicIds = topicIds ?? const [];

  UserDataEntity copyWith({
    String? uid,
    String? profileImgUrl,
    String? nickname,
    List<JobGroup>? jobGroups,
    List<String>? topicIds,
  }) {
    return UserDataEntity(
      uid: uid ?? this.uid,
      profileImgUrl: profileImgUrl ?? this.profileImgUrl,
      nickname: nickname ?? this.nickname,
      jobGroupIds: jobGroups ?? this.jobGroups,
      topicIds: topicIds ?? this.topicIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'profileImgUrl': this.profileImgUrl,
      'nickname': this.nickname,
      'jobGroupIds': this.jobGroups,
      'topicIds': this.topicIds,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataEntity &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          profileImgUrl == other.profileImgUrl &&
          nickname == other.nickname &&
          jobGroups == other.jobGroups &&
          topicIds == other.topicIds;

  @override
  int get hashCode =>
      uid.hashCode ^
      profileImgUrl.hashCode ^
      nickname.hashCode ^
      jobGroups.hashCode ^
      topicIds.hashCode;
}
