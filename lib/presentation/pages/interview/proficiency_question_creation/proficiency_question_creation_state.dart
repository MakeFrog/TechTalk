import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/presentation/providers/user/user_info_provider.dart';

mixin class ProficiencyQuestionCreationState {
  ///
  /// 유저 정보
  ///
  Future<String?> nicknameFuture(WidgetRef ref) async {
    final info = await ref.watch(userInfoProvider.future);
    return info?.nickname;
  }
}
