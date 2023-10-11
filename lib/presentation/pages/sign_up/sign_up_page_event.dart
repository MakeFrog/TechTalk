import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/core/core.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_form_provider.dart';
import 'package:techtalk/presentation/pages/sign_up/providers/sign_up_step_controller_provider.dart';

final Debouncer _nicknameValidateDebouncer = Debouncer(1.seconds);

mixin class SignUpPageEvent {
  /// 앱바의 [BackButton]을 눌렀을 때 실행할 콜백
  ///
  /// 이전 회원가입 단계로 넘어간다. 이전 단계로 넘어갈 시 현재 단계에 작성한 데이터는 삭제한다.
  void onTapBackButton(WidgetRef ref) {
    ref.read(signUpStepControllerProvider.notifier).prev();
    // TODO : 단계별 데이터 삭제 로직
  }

  /// 닉네임 필드가 변경될 떄마다 실행할 콜백
  ///
  /// 로딩 인디케이터 표시를 위해 [isRunningDebouncer]를 콜백 시작과 끝에 변경한다.
  /// [debouncer]를 통헤 여러번 입력하더라도 마지막 입력만 검사하도록 제한한다.
  /// 입력 사이의 제한시간은 1초로 지정한다.
  Future<void> onChangeNicknameField(
    WidgetRef ref, {
    required String nickname,
    required ValueNotifier<bool> isRunningDebouncer,
  }) async {
    // 입력받은 nickname이 비어있다면 콜백을 중단하고 닉네임 데이터를 초기화한다.
    if (nickname.isEmpty) {
      isRunningDebouncer.value = false;
      _nicknameValidateDebouncer.reset();
      ref.read(signUpFormProvider.notifier).clearNickname();
    } else {
      isRunningDebouncer.value = true;

      _nicknameValidateDebouncer.call(
        () async {
          await ref.read(signUpFormProvider.notifier).updateNickname(nickname);

          isRunningDebouncer.value = false;
        },
      );
    }
  }

  /// 닉네임 필드의 클리어 아이콘을 눌렀을 때 실행할 콜백
  ///
  /// [controller]에 입력된 텍스트와 닉네임 데이터를 초기화한다.
  void onClearNicknameField(
    WidgetRef ref, {
    required TextEditingController controller,
  }) {
    ref.read(signUpFormProvider.notifier).clearNickname();
    controller.clear();
  }

  /// 다음단계 버튼을 눌렀을 때 실행할 콜백
  Future<void> onTapNicknamePageNext(WidgetRef ref) async {
    //? 현재는 컨트롤러 값만 바뀌주고있음
    //? 단계 변경 전 닉네임 검사를 한번 더 할지, 닉네임 검사를 끝내면 임시로 닉네임을 점유할지 등 고민 필요

    ref.read(signUpStepControllerProvider.notifier).next();
  }
}
