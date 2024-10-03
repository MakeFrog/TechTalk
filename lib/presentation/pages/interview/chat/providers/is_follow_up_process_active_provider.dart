import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_follow_up_process_active_provider.g.dart';

///
/// 꼬리 질문 활성화 여부
///
@riverpod
class IsFollowUpProcessActive extends _$IsFollowUpProcessActive {
  @override
  bool build() {
    return true;
  }

  void toggle() {
    state = !state;
  }
}
