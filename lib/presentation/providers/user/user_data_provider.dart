import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/features/user/entities/sign_up_form_entity.dart';
import 'package:techtalk/features/user/user.dart';
import 'package:techtalk/presentation/providers/user/user_auth_provider.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  FutureOr<UserDataEntity?> build() async {
    final userAuth = ref.watch(userAuthProvider);

    if (userAuth == null) throw Exception('로그인 필요');

    final userData = await getUserDataUseCase();

    return userData;
  }

  Future<void> createUserData(SignUpFormEntity signUpForm) async {
    final userUid = ref.read(userAuthProvider)!.uid;

    final userData = UserDataEntity(
      uid: userUid,
      nickname: signUpForm.nickname,
      jobGroupIds: signUpForm.jobGroupList.map((e) => e.id).toList(),
      topicIds: signUpForm.techSkillList.map((e) => e.id).toList(),
    );

    await createUserDataUseCase(userData);

    ref.invalidateSelf();

    await future;
  }

  void updateUserData() {}
}
