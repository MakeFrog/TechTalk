import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/presentation/providers/user/auth/user_auth_provider.dart';

part 'is_user_authorized_provider.g.dart';

/// 현재 앱 사용자가 인증되었는지 여부
///
/// * 현재는 단순 유저 인증 정보가 있나 없나로 판단. 테스트 후 다른 조건이 필요한지 찾아볼 것
@riverpod
bool isUserAuthorized(IsUserAuthorizedRef ref) =>
    ref.watch(userAuthProvider) != null;
