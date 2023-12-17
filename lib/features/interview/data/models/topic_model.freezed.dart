// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topic_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) {
  return _TopicModel.fromJson(json);
}

/// @nodoc
mixin _$TopicModel {
  String get categoryId => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @TimeStampConverter()
  DateTime get lastUpdatedDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopicModelCopyWith<TopicModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicModelCopyWith<$Res> {
  factory $TopicModelCopyWith(
          TopicModel value, $Res Function(TopicModel) then) =
      _$TopicModelCopyWithImpl<$Res, TopicModel>;
  @useResult
  $Res call(
      {String categoryId,
      String imageUrl,
      String id,
      String name,
      @TimeStampConverter() DateTime lastUpdatedDate});
}

/// @nodoc
class _$TopicModelCopyWithImpl<$Res, $Val extends TopicModel>
    implements $TopicModelCopyWith<$Res> {
  _$TopicModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? imageUrl = null,
    Object? id = null,
    Object? name = null,
    Object? lastUpdatedDate = null,
  }) {
    return _then(_value.copyWith(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdatedDate: null == lastUpdatedDate
          ? _value.lastUpdatedDate
          : lastUpdatedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopicModelImplCopyWith<$Res>
    implements $TopicModelCopyWith<$Res> {
  factory _$$TopicModelImplCopyWith(
          _$TopicModelImpl value, $Res Function(_$TopicModelImpl) then) =
      __$$TopicModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String categoryId,
      String imageUrl,
      String id,
      String name,
      @TimeStampConverter() DateTime lastUpdatedDate});
}

/// @nodoc
class __$$TopicModelImplCopyWithImpl<$Res>
    extends _$TopicModelCopyWithImpl<$Res, _$TopicModelImpl>
    implements _$$TopicModelImplCopyWith<$Res> {
  __$$TopicModelImplCopyWithImpl(
      _$TopicModelImpl _value, $Res Function(_$TopicModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? imageUrl = null,
    Object? id = null,
    Object? name = null,
    Object? lastUpdatedDate = null,
  }) {
    return _then(_$TopicModelImpl(
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdatedDate: null == lastUpdatedDate
          ? _value.lastUpdatedDate
          : lastUpdatedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicModelImpl implements _TopicModel {
  const _$TopicModelImpl(
      {required this.categoryId,
      required this.imageUrl,
      required this.id,
      required this.name,
      @TimeStampConverter() required this.lastUpdatedDate});

  factory _$TopicModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicModelImplFromJson(json);

  @override
  final String categoryId;
  @override
  final String imageUrl;
  @override
  final String id;
  @override
  final String name;
  @override
  @TimeStampConverter()
  final DateTime lastUpdatedDate;

  @override
  String toString() {
    return 'TopicModel(categoryId: $categoryId, imageUrl: $imageUrl, id: $id, name: $name, lastUpdatedDate: $lastUpdatedDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicModelImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lastUpdatedDate, lastUpdatedDate) ||
                other.lastUpdatedDate == lastUpdatedDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, categoryId, imageUrl, id, name, lastUpdatedDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicModelImplCopyWith<_$TopicModelImpl> get copyWith =>
      __$$TopicModelImplCopyWithImpl<_$TopicModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicModelImplToJson(
      this,
    );
  }
}

abstract class _TopicModel implements TopicModel {
  const factory _TopicModel(
          {required final String categoryId,
          required final String imageUrl,
          required final String id,
          required final String name,
          @TimeStampConverter() required final DateTime lastUpdatedDate}) =
      _$TopicModelImpl;

  factory _TopicModel.fromJson(Map<String, dynamic> json) =
      _$TopicModelImpl.fromJson;

  @override
  String get categoryId;
  @override
  String get imageUrl;
  @override
  String get id;
  @override
  String get name;
  @override
  @TimeStampConverter()
  DateTime get lastUpdatedDate;
  @override
  @JsonKey(ignore: true)
  _$$TopicModelImplCopyWith<_$TopicModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
