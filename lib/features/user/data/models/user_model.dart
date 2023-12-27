import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techtalk/features/user/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserModel {
  UserModel({
    required this.uid,
    this.profileImgUrl,
    this.nickname,
    this.jobGroupIds,
    this.topicIds,
  });

  /// 유저 UID
  String uid;

  /// 유저 프로필 이미지 URL
  String? profileImgUrl;

  /// 유저 닉네임
  String? nickname;

  /// 유저 관심 직군 ID 목록
  List<String>? jobGroupIds;

  /// 유저가 준비하고 있는 기술면접 주제 ID 목록
  List<String>? topicIds;

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      profileImgUrl: entity.profileImgUrl,
      nickname: entity.nickname,
      jobGroupIds: entity.jobGroupIds,
      topicIds: entity.topicIds,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      profileImgUrl: profileImgUrl,
      nickname: nickname,
      jobGroupIds: jobGroupIds,
      topicIds: topicIds,
    );
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) =>
      UserModel.fromJson(snapshot.data()!);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
