import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:techtalk/app/router/router.dart';
import 'package:techtalk/core/index.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_local_data_info_provider.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_preview_path_provider.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_temp_data_info_provider.dart';
import 'package:techtalk/presentation/pages/resume_manage/resume_manage_page.dart';
import 'package:techtalk/presentation/widgets/common/dialog/app_dialog.dart';

mixin class ResumeManageEvent {
  /// 설정 bottom sheet 모달창 노출
  void onRegisteredFileBtnTapped(
    WidgetRef ref, {
    required bool isResume,
    required bool isLocal,
  }) {
    showModalBottomSheet(
      context: ref.context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return ResumeManageBottomSheet(
          onCloseBtnTapped: context.pop,
          onOptionTapped: (int index) {
            switch (index) {
              case 0: // 변경
                isResume
                    ? resumePickAndSaveFile(ref)
                    : portfolioPickAndSaveFile(ref);
                break;
              case 1: // 미리보기
                onClickedPreviewBtn(ref, isLocal: isLocal, isResume: isResume);
                break;
              case 2: // 삭제
                onClickedDeleteBtn(ref, isLocal: isLocal, isResume: isResume);
                break;
              default:
                break;
            }
          },
        );
      },
    );
  }

  /// 미리보기 버튼 클릭시
  /// TODO: 이력서 미리보기 기능 구현하기
  void onClickedPreviewBtn(
    WidgetRef ref, {
    required bool isResume,
    required bool isLocal,
  }) {
    final tempState = ref.read(resumeTempDataInfoProvider);
    final localState = ref.read(resumeLocalDataInfoProvider);

    // 미리보기용 pdf 경로
    late final String? previewPath;

    if (isResume) {
      previewPath =
          isLocal ? localState.localResumePath : tempState.tempResumePath;
    } else {
      previewPath =
          isLocal ? localState.localPortfolioPath : tempState.tempPortfolioPath;
    }

    if (previewPath == null) {
      debugPrint('PDF 경로가 존재하지 않습니다.');
      return;
    }

    // -- (1) resumePreviewPathProvider 값 업데이트
    ref.read(resumePreviewPathProvider.notifier).state = previewPath;

    // -- (2) 페이지 이동 시에는 인자를 직접 넘기지 않고, provider로부터 읽도록 만듦
    const ResumePreviewRoute().push(ref.context);
  }

  /// 삭제 버튼 클릭시
  void onClickedDeleteBtn(
    WidgetRef ref, {
    required bool isResume,
    required bool isLocal,
  }) {
    final tempNotifier = ref.read(resumeTempDataInfoProvider.notifier);
    final localNotifier = ref.read(resumeLocalDataInfoProvider.notifier);

    DialogService.show(
      dialog: AppDialog.dividedBtn(
        title: '삭제',
        description: '삭제하시겠습니까?',
        leftBtnContent: '취소',
        rightBtnContent: '삭제',
        onRightBtnClicked: () {
          debugPrint('isResume : $isResume');
          debugPrint('isLocal : $isLocal');

          isResume
              ? isLocal // 이력서 파일
                  ? localNotifier.updateLocalResume(null, null, null)
                  : tempNotifier.updateTempResume(null, null, null)
              : isLocal // 포트폴리오 파일
                  ? localNotifier.updateLocalPortfolio(null, null, null)
                  : tempNotifier.updateTempPortfolio(null, null, null);

          ref.context.pop();
        },
        onLeftBtnClicked: () => ref.context.pop(),
        showContentImg: false,
      ),
    );
  }

  ///
  /// 저장하기 버튼 클릭시
  ///
  Future<void> onClickedSaveBtn(WidgetRef ref) async {
    await EasyLoading.show();

    final tempState = ref.read(resumeTempDataInfoProvider);
    final tempNotifier = ref.read(resumeTempDataInfoProvider.notifier);
    final localNotifier = ref.read(resumeLocalDataInfoProvider.notifier);

    // 1) 이력서 PDF 업데이트
    if (tempState.tempResumePath != null) {
      final appDocDir = await getApplicationDocumentsDirectory();
      final localResumePath = '${appDocDir.path}/${tempState.tempResumeTitle}';

      // 임시 경로 → 앱 문서 디렉토리로 복사
      await File(tempState.tempResumePath!).copy(localResumePath);

      // ResumeLocalDataInfoProvider 갱신
      localNotifier.updateLocalResume(
        localResumePath,
        tempState.tempResumeTitle ?? '',
        tempState.tempResumeDate ?? '',
      );

      // TODO : 이력서 업데이트 후 기존에 저장되어있던 파일을 삭제해야함
    }

    // 2) 포트폴리오 PDF 업데이트
    if (tempState.tempPortfolioPath != null) {
      final appDocDir = await getApplicationDocumentsDirectory();
      final localPortfolioPath =
          '${appDocDir.path}/${tempState.tempPortfolioTitle}';

      // 임시 경로 → 앱 문서 디렉토리로 복사
      await File(tempState.tempPortfolioPath!).copy(localPortfolioPath);

      // ResumeLocalDataInfoProvider 갱신
      localNotifier.updateLocalPortfolio(
        localPortfolioPath,
        tempState.tempPortfolioTitle ?? '',
        tempState.tempPortfolioDate ?? '',
      );

      // TODO : 포트폴리오 업데이트 후 기존에 저장되어있던 파일을 삭제해야함
    }

    // 3) Temp State 초기화
    tempNotifier.resetTempState();

    // 저장 완료 후
    await EasyLoading.dismiss();
    if (ref.context.mounted) {
      ref.context.pop();
    }
  }

  ///
  /// 이력서 파일 선택시
  ///
  Future<void> resumePickAndSaveFile(WidgetRef ref) async {
    const maxFileSizeInBytes = 50 * 1024 * 1024;

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) {
        return;
      }

      final pickedFile = File(result.files.single.path!);

      if (pickedFile.lengthSync() > maxFileSizeInBytes) {
        DialogService.show(
          dialog: AppDialog.dividedBtn(
            title: '용량이 초과됐어요',
            subTitle: '50MB보다 큰 파일은 등록할 수 없어요',
            leftBtnContent: '취소',
            rightBtnContent: '다시 올리기',
            showContentImg: true,
            onRightBtnClicked: () {
              ref.context.pop();
              // 이후 다시 파일 업로드하기
            },
            onLeftBtnClicked: ref.context.pop,
            customAssetPath: Assets.iconsPolygonWarning,
          ),
        );
      }

      if (pickedFile.lengthSync() < maxFileSizeInBytes) {
        Directory tempDocDir = await getTemporaryDirectory();
        String filePath = result.files.single.path!;
        String tempResumeTitle = result.files.single.name;

        String tempResumePath = '${tempDocDir.path}/$tempResumeTitle';
        await File(filePath).copy(tempResumePath);

        String tempResumeDate = DateFormat('yyyy.MM.dd').format(DateTime.now());

        // 값 업데이트
        final notifier = ref.read(resumeTempDataInfoProvider.notifier);
        notifier.updateTempResume(
          tempResumePath,
          tempResumeTitle,
          tempResumeDate,
        );
      } else {
        throw Exception('No file selected or invalid file path.');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  /// 포트폴리오 파일 선택시
  Future<void> portfolioPickAndSaveFile(WidgetRef ref) async {
    const maxFileSizeInBytes = 50 * 1024 * 1024;

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) {
        return;
      }

      final pickedFile = File(result.files.single.path!);

      if (pickedFile.lengthSync() > maxFileSizeInBytes) {
        DialogService.show(
          dialog: AppDialog.dividedBtn(
            title: '용량이 초과됐어요',
            subTitle: '50MB보다 큰 파일은 등록할 수 없어요',
            leftBtnContent: '취소',
            rightBtnContent: '다시 올리기',
            showContentImg: true,
            onRightBtnClicked: () {
              ref.context.pop();
              // 이후 다시 파일 업로드하기
            },
            onLeftBtnClicked: ref.context.pop,
            customAssetPath: Assets.iconsPolygonWarning,
          ),
        );
      }

      if (pickedFile.lengthSync() < maxFileSizeInBytes) {
        Directory tempDocDir = await getTemporaryDirectory();
        String filePath = result.files.single.path!;
        String tempPortfolioTitle = result.files.single.name;

        String tempPortfolioPath = '${tempDocDir.path}/$tempPortfolioTitle';
        await File(filePath).copy(tempPortfolioPath);

        String tempPortfolioDate =
            DateFormat('yyyy.MM.dd').format(DateTime.now());

        // 값 업데이트
        ref.read(resumeTempDataInfoProvider.notifier).updateTempPortfolio(
              tempPortfolioPath,
              tempPortfolioTitle,
              tempPortfolioDate,
            );

        debugPrint('tempPortfolioPath : $tempPortfolioPath');
        debugPrint('tempPortfolioTitle : $tempPortfolioTitle');
        debugPrint('tempPortfolioDate : $tempPortfolioDate');
      } else {
        throw Exception('No file selected or invalid file path.');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
