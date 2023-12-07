import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/models/exception/custom_exception.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(
    this._userRemoteDataSource,
  );

  final UserRemoteDataSource _userRemoteDataSource;

  String get _userUid {
    try {
      return FirebaseAuth.instance.currentUser!.uid;
    } catch (e) {
      throw const UnAuthorizedException();
    }
  }

  @override
  Future<Result<void>> createUserData(UserDataEntity data) async {
    try {
      return Result.success(
        _userRemoteDataSource.createUserData(data.toModel()),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserDataEntity?>> getUserData() async {
    try {
      var userData = await _userRemoteDataSource.getUserData(_userUid);

      if (userData == null) {
        return Result.success(null);
      }

      return Result.success(
        UserDataEntity.fromModel(userData),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<bool>> isExistNickname(String nickname) async {
    try {
      final result = await _userRemoteDataSource.isExistNickname(nickname);

      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception(e));
    }
  }

  @override
  Future<Result<List<InterviewTopic>>> getUserTopicList() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final response = await _userRemoteDataSource.getUserData(uid);

      final topicIds = response?.topicIds ?? [];

      final result = topicIds.map(InterviewTopic.getTopicById).toList();

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
