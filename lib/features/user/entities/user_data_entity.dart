import 'package:techtalk/features/user/data/models/user_data_model.dart';

class UserDataEntity {
  final String uid;
  final String? nickname;
  final List<String> jobGroupIdList;
  final List<String> skillIdList;

  bool get isCompleteSignUp => nickname != null;

  UserDataModel toModel() => UserDataModel(
        uid: uid,
        nickname: nickname,
        jobGroupIds: jobGroupIdList,
        topicIds: skillIdList,
      );
  factory UserDataEntity.fromModel(UserDataModel model) => UserDataEntity(
        uid: model.uid,
        nickname: model.nickname,
        interestedJobGroupIdList: model.jobGroupIds ?? [],
        techSkillIdList: model.topicIds ?? [],
      );

//<editor-fold desc="Data Methods">
  const UserDataEntity({
    required this.uid,
    this.nickname,
    List<String>? interestedJobGroupIdList,
    List<String>? techSkillIdList,
  })  : jobGroupIdList = interestedJobGroupIdList ?? const [],
        skillIdList = techSkillIdList ?? const [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDataEntity &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          nickname == other.nickname &&
          jobGroupIdList == other.jobGroupIdList &&
          skillIdList == other.skillIdList);

  @override
  int get hashCode =>
      uid.hashCode ^
      nickname.hashCode ^
      jobGroupIdList.hashCode ^
      skillIdList.hashCode;

  @override
  String toString() {
    return 'UserDataEntity{' +
        ' uid: $uid,' +
        ' nickname: $nickname,' +
        ' interestedJobGroupIdList: $jobGroupIdList,' +
        ' techSkillIdList: $skillIdList,' +
        '}';
  }

  UserDataEntity copyWith({
    String? uid,
    String? nickname,
    List<String>? interestedJobGroupIdList,
    List<String>? techSkillIdList,
  }) {
    return UserDataEntity(
      uid: uid ?? this.uid,
      nickname: nickname ?? this.nickname,
      interestedJobGroupIdList: interestedJobGroupIdList ?? this.jobGroupIdList,
      techSkillIdList: techSkillIdList ?? this.skillIdList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'nickname': this.nickname,
      'interestedJobGroupIdList': this.jobGroupIdList,
      'techSkillIdList': this.skillIdList,
    };
  }

  factory UserDataEntity.fromMap(Map<String, dynamic> map) {
    return UserDataEntity(
      uid: map['uid'] as String,
      nickname: map['nickname'] as String,
      interestedJobGroupIdList: map['interestedJobGroupIdList'] as List<String>,
      techSkillIdList: map['techSkillIdList'] as List<String>,
    );
  }

//</editor-fold>
}
