import 'package:techtalk/core/utils/result.dart';

abstract interface class SignUpRepository {
  Future<Result<bool>> isExistNickname(String nickname);
}
