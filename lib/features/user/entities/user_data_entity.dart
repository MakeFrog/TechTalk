import 'package:techtalk/features/user/data/models/user_data_model.dart';

class UserDataEntity {
  final String uid;
  final String? nickname;
  final List<String> interestedJobGroupIdList;
  final List<String> techSkillIdList;

  bool get isCompleteSignUp => nickname != null;

  UserDataModel toModel() => UserDataModel(
        uid: uid,
        nickname: nickname,
        jobGroupIds: interestedJobGroupIdList,
        topicIds: techSkillIdList,
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
  })  : interestedJobGroupIdList = interestedJobGroupIdList ?? const [],
        techSkillIdList = techSkillIdList ?? const [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserDataEntity &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          nickname == other.nickname &&
          interestedJobGroupIdList == other.interestedJobGroupIdList &&
          techSkillIdList == other.techSkillIdList);

  @override
  int get hashCode =>
      uid.hashCode ^
      nickname.hashCode ^
      interestedJobGroupIdList.hashCode ^
      techSkillIdList.hashCode;

  @override
  String toString() {
    return 'UserDataEntity{' +
        ' uid: $uid,' +
        ' nickname: $nickname,' +
        ' interestedJobGroupIdList: $interestedJobGroupIdList,' +
        ' techSkillIdList: $techSkillIdList,' +
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
      interestedJobGroupIdList:
          interestedJobGroupIdList ?? this.interestedJobGroupIdList,
      techSkillIdList: techSkillIdList ?? this.techSkillIdList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'nickname': this.nickname,
      'interestedJobGroupIdList': this.interestedJobGroupIdList,
      'techSkillIdList': this.techSkillIdList,
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
