import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:techtalk/app/localization/locale_keys.g.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_local_data_info_provider.dart';
import 'package:techtalk/presentation/pages/resume_manage/providers/resume_temp_data_info_provider.dart';
import 'package:gap/gap.dart';
import 'package:techtalk/app/style/app_color.dart';
import 'package:techtalk/app/style/app_text_style.dart';
import 'package:techtalk/core/services/app_size.dart';

mixin class ResumeManageEvent {
  ///
  /// 설정 bottom sheet 모달창 노출
  ///
  void onRegisteredFileBtnTapped(WidgetRef ref, {required bool isResume}) {
    showModalBottomSheet(
      context: ref.context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _OptionListBottomSheet(
          onCloseBtnTapped: context.pop,
          onOptionTapped: (int index) {
            switch (index) {
              case 0: // 변경
                editFile();
                break;
              case 1: // 미리보기
                previewFile();
                break;
              case 2: // 삭제
                final notifier = ref.read(resumeTempDataInfoProvider.notifier);
                isResume
                    ? notifier.updateTempResume(null, null, null)
                    : notifier.updateTempPortfolio(null, null, null);
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

  /// 저장하기 버튼 클릭시
  Future<void> onClickedSaveButton(WidgetRef ref) async {
    await EasyLoading.show();

    final tempState = ref.read(resumeTempDataInfoProvider);
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
    }

    // 저장 완료 후
    await EasyLoading.dismiss();
    ref.context.pop();
  }

  /// 이력서 파일 선택시
  Future<void> resumePickAndSaveFile(WidgetRef ref) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
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
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
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

///
/// 예외 경우라 위젯 따로 만듦
/// 위젯 폴더로 이동시킬 예정
///
class _OptionListBottomSheet<T extends dynamic> extends StatelessWidget {
  const _OptionListBottomSheet({
    Key? key,
    required this.onOptionTapped,
    required this.onCloseBtnTapped,
  }) : super(key: key);

  final void Function(int index) onOptionTapped;
  final VoidCallback onCloseBtnTapped;

  final List<String> _options = const ['변경', '미리보기', '삭제'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: context.pop,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16) +
              EdgeInsets.only(bottom: AppSize.bottomInset == 0 ? 12 : 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColor.of.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                width: double.infinity,
                child: Center(
                  child: Text(
                    '이력서',
                    style: AppTextStyle.alert2,
                  ),
                ),
              ),
              Container(
                height: 0.5,
                width: double.infinity,
                color: AppColor.of.gray2,
              ),
              ListView.separated(
                separatorBuilder: (_, __) => Container(
                  height: 0.5,
                  width: double.infinity,
                  color: AppColor.of.gray2,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _options.length,
                itemBuilder: (context, index) {
                  return MaterialButton(
                    color: AppColor.of.white,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: _options.length == index + 1
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            )
                          : BorderRadius.zero,
                    ),
                    onPressed: () {
                      context.pop();
                      onOptionTapped(index);
                    },
                    child: SizedBox(
                      height: 56,
                      child: Center(
                        child: Text(
                          _options[index],
                          style: index == _options.length - 1
                              ? AppTextStyle.title2.copyWith(
                                  color: Colors.red,
                                )
                              : AppTextStyle.title2,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Gap(8),
              MaterialButton(
                color: AppColor.of.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: onCloseBtnTapped,
                child: SizedBox(
                  height: 56,
                  child: Center(
                    child: Text(
                      context.tr(
                        LocaleKeys.common_close,
                      ),
                      style: AppTextStyle.title3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
