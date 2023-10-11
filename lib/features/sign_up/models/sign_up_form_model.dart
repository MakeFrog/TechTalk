import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_form_model.freezed.dart';
part 'sign_up_form_model.g.dart';

@freezed
class SignUpFormModel with _$SignUpFormModel {
  const factory SignUpFormModel({
    String? nickname,
    String? nicknameValidation,
  }) = _SignUpFormModel;

  const SignUpFormModel._();

  bool get isPassNickname => nickname != null && nicknameValidation == null;

  factory SignUpFormModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpFormModelFromJson(json);
}
