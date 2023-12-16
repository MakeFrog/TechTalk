import 'package:firebase_auth/firebase_auth.dart';
import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview/data/remote/interview_remote_data_source.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';
import 'package:techtalk/features/user/data/remote/user_remote_data_source.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';
import 'package:techtalk/features/user/repositories/user_repository.dart';

final class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(
    this._userRemoteDataSource,
    this._interviewRemoteDataSource,
  );

  final UserRemoteDataSource _userRemoteDataSource;
  final InterviewRemoteDataSource _interviewRemoteDataSource;

  @override
  Future<void> createUserData(UserDataEntity data) async {
    await _userRemoteDataSource.createUserData(data.toModel());
  }

  @override
  Future<UserDataEntity?> getUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    var userData = await _userRemoteDataSource.getUserData(uid);

    if (userData == null) {
      return null;
    }

    return UserDataEntity.fromModel(userData);
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
  Future<Result<List<TopicEntity>>> getUserTopicList() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final response = await _userRemoteDataSource.getUserData(uid);

      final topicIds = response?.topicIds ?? [];

      List<TopicEntity> mappedTopics = [];

      for (var id in topicIds) {
        final response = await _interviewRemoteDataSource.getTopicById(id);
        if (response == null) break;
        final result = TopicEntity.fromModel(response);
        mappedTopics.add(result);
      }

      return Result.success(mappedTopics);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
