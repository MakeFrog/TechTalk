import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/job/models/job_group_model.dart';

part 'sign_up_form_model.freezed.dart';
part 'sign_up_form_model.g.dart';

@freezed
class SignUpFormModel with _$SignUpFormModel {
  const factory SignUpFormModel({
    String? nickname,
    String? nicknameValidation,
    @Default([]) List<JobGroupModel> selectedJobGroupList,
  }) = _SignUpFormModel;

  const SignUpFormModel._();

  bool get isPassNickname => nickname != null && nicknameValidation == null;

  factory SignUpFormModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpFormModelFromJson(json);
}
