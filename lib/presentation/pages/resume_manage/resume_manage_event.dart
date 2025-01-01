import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/presentation/widgets/common/bottom_sheet/option_list_bottom_sheet.dart';

mixin class ResumeManageEvent {
  ///
  /// 설정 bottom sheet 모달창 노출
  ///
  void onRegisteredFileBtnTapped(WidgetRef ref) {
    showModalBottomSheet(
      context: ref.context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return OptionListBottomSheet(
          leadingText: tr(LocaleKeys.myInfo_editMyInfo_editMyInfo),
          onCloseBtnTapped: context.pop,
          options: const ['변경', '미리보기', '삭제'],
          onOptionTapped: (int index) {
            switch (index) {
              case 0: // 변경
                editFile();
                break;
              case 1: // 미리보기
                previewFile();
                break;
              case 2: // 삭제
                deleteFile();
                break;
              default:
                break;
            }
          },
        );
      },
    );
  }

  void editFile() {
    debugPrint('변경');
  }

  void previewFile() {
    debugPrint('미리보기');
  }

  void deleteFile() {
    debugPrint('삭제');
  }
}
