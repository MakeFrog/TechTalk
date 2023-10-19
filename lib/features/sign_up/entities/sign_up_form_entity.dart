import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/job/models/job_group_model.dart';

part 'sign_up_form_entity.freezed.dart';
part 'sign_up_form_entity.g.dart';

@freezed
class SignUpFormEntity with _$SignUpFormEntity {
  const factory SignUpFormEntity({
    String? nickname,
    String? nicknameValidation,
    @Default([]) List<JobGroupModel> selectedJobGroupList,
  }) = _SignUpFormEntity;

  const SignUpFormEntity._();

  bool get isPassNickname => nickname != null && nicknameValidation == null;

  factory SignUpFormEntity.fromJson(Map<String, dynamic> json) =>
      _$SignUpFormEntityFromJson(json);
}
