// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_form_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SignUpFormModel _$SignUpFormModelFromJson(Map<String, dynamic> json) {
  return _SignUpFormModel.fromJson(json);
}

/// @nodoc
mixin _$SignUpFormModel {
  String? get nickname => throw _privateConstructorUsedError;
  String? get nicknameValidation => throw _privateConstructorUsedError;
  List<JobGroupModel> get selectedJobGroupList =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignUpFormModelCopyWith<SignUpFormModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpFormModelCopyWith<$Res> {
  factory $SignUpFormModelCopyWith(
          SignUpFormModel value, $Res Function(SignUpFormModel) then) =
      _$SignUpFormModelCopyWithImpl<$Res, SignUpFormModel>;
  @useResult
  $Res call(
      {String? nickname,
      String? nicknameValidation,
      List<JobGroupModel> selectedJobGroupList});
}

/// @nodoc
class _$SignUpFormModelCopyWithImpl<$Res, $Val extends SignUpFormModel>
    implements $SignUpFormModelCopyWith<$Res> {
  _$SignUpFormModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = freezed,
    Object? nicknameValidation = freezed,
    Object? selectedJobGroupList = null,
  }) {
    return _then(_value.copyWith(
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      nicknameValidation: freezed == nicknameValidation
          ? _value.nicknameValidation
          : nicknameValidation // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedJobGroupList: null == selectedJobGroupList
          ? _value.selectedJobGroupList
          : selectedJobGroupList // ignore: cast_nullable_to_non_nullable
              as List<JobGroupModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpFormModelImplCopyWith<$Res>
    implements $SignUpFormModelCopyWith<$Res> {
  factory _$$SignUpFormModelImplCopyWith(_$SignUpFormModelImpl value,
          $Res Function(_$SignUpFormModelImpl) then) =
      __$$SignUpFormModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? nickname,
      String? nicknameValidation,
      List<JobGroupModel> selectedJobGroupList});
}

/// @nodoc
class __$$SignUpFormModelImplCopyWithImpl<$Res>
    extends _$SignUpFormModelCopyWithImpl<$Res, _$SignUpFormModelImpl>
    implements _$$SignUpFormModelImplCopyWith<$Res> {
  __$$SignUpFormModelImplCopyWithImpl(
      _$SignUpFormModelImpl _value, $Res Function(_$SignUpFormModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nickname = freezed,
    Object? nicknameValidation = freezed,
    Object? selectedJobGroupList = null,
  }) {
    return _then(_$SignUpFormModelImpl(
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      nicknameValidation: freezed == nicknameValidation
          ? _value.nicknameValidation
          : nicknameValidation // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedJobGroupList: null == selectedJobGroupList
          ? _value._selectedJobGroupList
          : selectedJobGroupList // ignore: cast_nullable_to_non_nullable
              as List<JobGroupModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignUpFormModelImpl extends _SignUpFormModel {
  const _$SignUpFormModelImpl(
      {this.nickname,
      this.nicknameValidation,
      final List<JobGroupModel> selectedJobGroupList = const []})
      : _selectedJobGroupList = selectedJobGroupList,
        super._();

  factory _$SignUpFormModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignUpFormModelImplFromJson(json);

  @override
  final String? nickname;
  @override
  final String? nicknameValidation;
  final List<JobGroupModel> _selectedJobGroupList;
  @override
  @JsonKey()
  List<JobGroupModel> get selectedJobGroupList {
    if (_selectedJobGroupList is EqualUnmodifiableListView)
      return _selectedJobGroupList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedJobGroupList);
  }

  @override
  String toString() {
    return 'SignUpFormModel(nickname: $nickname, nicknameValidation: $nicknameValidation, selectedJobGroupList: $selectedJobGroupList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpFormModelImpl &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.nicknameValidation, nicknameValidation) ||
                other.nicknameValidation == nicknameValidation) &&
            const DeepCollectionEquality()
                .equals(other._selectedJobGroupList, _selectedJobGroupList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nickname, nicknameValidation,
      const DeepCollectionEquality().hash(_selectedJobGroupList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpFormModelImplCopyWith<_$SignUpFormModelImpl> get copyWith =>
      __$$SignUpFormModelImplCopyWithImpl<_$SignUpFormModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignUpFormModelImplToJson(
      this,
    );
  }
}

abstract class _SignUpFormModel extends SignUpFormModel {
  const factory _SignUpFormModel(
      {final String? nickname,
      final String? nicknameValidation,
      final List<JobGroupModel> selectedJobGroupList}) = _$SignUpFormModelImpl;
  const _SignUpFormModel._() : super._();

  factory _SignUpFormModel.fromJson(Map<String, dynamic> json) =
      _$SignUpFormModelImpl.fromJson;

  @override
  String? get nickname;
  @override
  String? get nicknameValidation;
  @override
  List<JobGroupModel> get selectedJobGroupList;
  @override
  @JsonKey(ignore: true)
  _$$SignUpFormModelImplCopyWith<_$SignUpFormModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
