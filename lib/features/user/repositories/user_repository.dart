import 'package:techtalk/core/utils/result.dart';
import 'package:techtalk/features/chat/chat.dart';
import 'package:techtalk/features/user/entities/user_data_entity.dart';

abstract interface class UserRepository {
  Future<void> createUserData(UserDataEntity data);
  Future<UserDataEntity?> getUserData(String uid);
  Future<Result<List<InterviewTopic>>> getUserTopicList();
  Future<bool> isExistNickname(String nickname);
}
