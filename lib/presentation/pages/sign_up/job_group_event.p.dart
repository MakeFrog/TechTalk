part of 'sign_up_event.dart';

extension JobGroupEvent on SignUpEvent {
  ///
  /// 직군 ListTile이 클릭되었을 때
  ///
  void onJobGroupListTileTapped(WidgetRef ref, {required JobGroup item}) {
    final selectedJobGroups = ref.read(selectedJobGroupsProvider);
    if (selectedJobGroups.contains(item)) {
      ref.read(selectedJobGroupsProvider.notifier).remove(item);
    } else {
      ref.read(selectedJobGroupsProvider.notifier).add(item);
    }
  }

  ///
  /// 선택된 직군 Chip 위젯이 클릭 되었을 때
  ///
  void onJogGroupChipTapped(WidgetRef ref, {required JobGroup item}) {
    ref.read(selectedJobGroupsProvider.notifier).remove(item);
  }

  ///
  /// 닉네임 단계에서 '다음' 버튼이 클릭 되었을 때
  ///
  void onJobGroupStepBtnTapped(WidgetRef ref) {
    ref.read(signUpStepControllerProvider.notifier).next();
  }
}
