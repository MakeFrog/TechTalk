import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/interview/entities/topic_entity.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';

abstract interface class UserRepository {
  Future<void> createUserData(UserDataEntity data);
  Future<UserDataEntity?> getUserData();
  Future<Result<List<TopicEntity>>> getUserTopicList();
  Future<Result<bool>> isExistNickname(String nickname);
}
