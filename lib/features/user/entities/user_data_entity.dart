import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/user/data/models/user_data_model.dart';

part 'user_data_entity.freezed.dart';
part 'user_data_entity.g.dart';

@freezed
class UserDataEntity with _$UserDataEntity {
  const factory UserDataEntity({
    required String uid,
    String? nickname,
    @Default([]) List<String> interestedJobGroupIdList,
    @Default([]) List<String> techSkillIdList,
  }) = _UserDataEntity;

  const UserDataEntity._();

  bool get isCompleteSignUp => nickname != null;

  UserDataModel toModel() => UserDataModel(
        uid: uid,
        nickname: nickname,
        interestedJobGroupIdList: interestedJobGroupIdList,
        techSkillIdList: techSkillIdList,
      );
  factory UserDataEntity.fromModel(UserDataModel model) => UserDataEntity(
        uid: model.uid,
        nickname: model.nickname,
        interestedJobGroupIdList: model.interestedJobGroupIdList ?? [],
        techSkillIdList: model.techSkillIdList ?? [],
      );
  factory UserDataEntity.fromJson(Map<String, dynamic> json) =>
      _$UserDataEntityFromJson(json);
}