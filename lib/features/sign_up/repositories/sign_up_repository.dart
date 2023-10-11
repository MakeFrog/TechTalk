abstract interface class SignUpRepository {
  Future<bool> isExistNickname(String nickname);
}
