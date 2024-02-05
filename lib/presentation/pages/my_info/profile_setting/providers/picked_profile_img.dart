import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/services/dialog_service.dart';
import 'package:techtalk/core/services/toast_service.dart';
import 'package:techtalk/presentation/widgets/common/common.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

part 'picked_profile_img.g.dart';

///
/// 로컬에서 불러온 파일 이미지를 관리하는 프로바이더
///
@riverpod
class PickedProfileImg extends _$PickedProfileImg {
  @override
  File? build() {
    return null;
  }

  /// Image picker 리소스 객체
  final ImagePicker _picker = ImagePicker();

  ///
  /// 이미지 선택
  ///
  Future<void> pickImageFile() async {
    try {
      final imageSource = await _picker.pickImage(source: ImageSource.gallery);
      if (imageSource != null) {
        state = File(imageSource.path);
      }
    } on Exception catch (e) {
      if (e is PlatformException) {
        DialogService.show(
          dialog: AppDialog.dividedBtn(
            title: '권한 허용',
            subTitle: '사진첩 접근 권한을 허용해주셔야 프로필 이미지를 변경할 수 있습니다.',
            leftBtnContent: '취소',
            rightBtnContent: '설정하기',
            onRightBtnClicked: () async {
              rootNavigatorKey.currentContext?.pop();
              await AppSettings.openAppSettings(
                  type: AppSettingsType.internalStorage);
            },
            onLeftBtnClicked: () {
              rootNavigatorKey.currentContext?.pop();
            },
          ),
        );
      } else {
        log(e.toString());
        ToastService.show(
          const CustomToast(message: '사진첩에서 정상적으로 이미지를 불러오지 못했어요. 다시 시도해주세요'),
        );
      }
    }
  }

  ///
  ///
  ///
}
